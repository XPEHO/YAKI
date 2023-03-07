import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProviderInterceptor = Provider((ref) {
  // use dio instance to setup interceptors, which allow to use dynamic data
  final dio = Dio();
  final customInterceptor = AddTokenToHeader();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) =>
          customInterceptor.onRequest(options, handler),
    ),
  );
  return dio;
});

class AddTokenToHeader extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");

    options.headers.addAll({"x-access-token": token});
    //print('REQUEST[${options.method}] => PATH: ${options.path}');

    return super.onRequest(options, handler);
  }
}
