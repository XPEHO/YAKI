import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/data/models/teammate_or_captain.dart';

part 'login_api.g.dart';

@RestApi()
abstract class LoginApi {
  factory LoginApi(Dio dio, {required String baseUrl}) = _LoginApi;

  @POST('/login')
  Future<HttpResponse<TeammateOrCaptain?>> postLogin(@Body() Login login);
}
