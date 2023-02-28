import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/presentation/state/login_state.dart';

part 'login_api.g.dart';

@RestApi(baseUrl: 'http://192.168.1.117:3000')
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST('/login')
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<Login?> postLogin(@Body() Login login);

}
