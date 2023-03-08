import 'package:dio/dio.dart' ;
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/authentication.dart';
import 'package:yaki/data/models/login.dart';

part 'login_api.g.dart';

@RestApi()
abstract class LoginController {
  factory LoginController(Dio dio, {required String baseUrl}) = _LoginController;

  @POST('/login')
  Future<Authentication?> postLogin(@Body() Login login);
}
