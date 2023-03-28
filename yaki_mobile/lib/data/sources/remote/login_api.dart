import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/login_model.dart';

part 'login_api.g.dart';

@RestApi()
abstract class LoginApi {
  factory LoginApi(Dio dio, {required String baseUrl}) = _LoginApi;

  @POST('/login')
  Future<HttpResponse> postLogin(@Body() LoginModel login);
}
