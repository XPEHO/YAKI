import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final certificateProvider = Provider((ref) => "");

final securityContextProvider = Provider((ref) {
  final data = ref.read(certificateProvider);
  List<int> bytes = utf8.encode(data);
  var sccontext = SecurityContext.defaultContext;
  sccontext.setTrustedCertificatesBytes(bytes);
  return sccontext;
});

// Dio is a flutter http client,
/// Interceptor are meant to be intercept request / response / error before they are handled by then or catch
/// Depending of the overrided method, it will run custom action.
/// Here create a dio instance to add interceptor, which allow to use dynamic data
final dioInterceptor = Provider(
  (ref) {
    final dio = Dio();
    final addDataToHeader = AddDataToHeader();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) =>
            addDataToHeader.onRequest(options, handler),
      ),
    );
    if (!kDebugMode) {
      final sccontext = ref.read(securityContextProvider);
      //final cer = ref.read(certificateProvider);
      dio.httpClientAdapter = IOHttpClientAdapter(
        onHttpClientCreate: (_) {
          return HttpClient(context: sccontext)
            ..badCertificateCallback = (_, __, ___) => true;
        },
        validateCertificate: (certificate, host, port) {
          return true;
          //certificate.pem == cer;
        },
      );
    }
    return dio;
  },
);

/// Custom interceptor, to, on any request
/// ( as long as the custom dioInterceptor is used at *_api.dart instantiation, ex : see declaration_provider.dart ),
/// add the token & userId (from authentication response) saved in the sharedPreference to the request header.
/// Overwrite Interceptor onRequest method for this.
class AddDataToHeader extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    var userId = prefs.get("userId");

    options.headers.addAll({"x-access-token": token, "user_id": userId});

    return super.onRequest(options, handler);
  }
}
