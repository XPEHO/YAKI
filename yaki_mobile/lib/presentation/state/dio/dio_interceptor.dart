import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Interceptor are meant to be intercept request / response / error
/// before they are handled by then or catch, and depending
/// of the override method, run custom action.
/// Create a dio instance to add interceptor, which allow to use dynamic data
final dioInterceptor = Provider(
  (ref) {
    final dio = Dio();
    final addTokenToHeader = AddTokenToHeader();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) =>
            addTokenToHeader.onRequest(options, handler),
      ),
    );
    return dio;
  },
);

/// Custom interceptor, to, on any request ( as long as the custom dio interceptor is used ),
/// add token save in sharedPreference to the request header.
/// Overwrite onRequest method for this action.
class AddTokenToHeader extends Interceptor {
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
