import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProviderInterceptor = Provider((ref) {
  // use dio instance to setup interceptors, which allow to use dynamic data
  final dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) => requestInterceptorTest(options),
    ),
  );
  return dio;
});


dynamic requestInterceptorTest(RequestOptions options) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("token");

  options.headers.addAll({"x-access-token": token});

  return options;
}