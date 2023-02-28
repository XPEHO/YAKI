import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/presentation/state/login_state.dart';

part 'login_api.g.dart';



@RestApi()
abstract class LoginService {
  factory LoginService(Dio dio, {required String baseUrl}) = _LoginService;

  @POST('/login')
  Future<Login?> postLogin(@Body() Login login);

}
