import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
