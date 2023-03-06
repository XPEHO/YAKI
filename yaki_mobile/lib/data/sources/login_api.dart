import 'package:dio/dio.dart' ;
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/authentication.dart';
import 'package:yaki/data/models/login.dart';

part 'login_api.g.dart';

@RestApi()
abstract class LoginService {
  factory LoginService(Dio dio, {required String baseUrl}) = _LoginService;


  @POST('/login')
  Future<Authentication?> postLogin(@Body() Login login);
}
