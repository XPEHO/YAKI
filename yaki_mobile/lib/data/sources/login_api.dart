import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/login.dart';

part 'login_api.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/login/')
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST('/login')
  Future<Login> postLogin();


}
