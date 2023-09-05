import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/password_changement_out.dart';

part "password_api.g.dart";

@RestApi()
abstract class PasswordApi {
  factory PasswordApi(Dio dio, {required String baseUrl}) = _PasswordApi;

  @POST('/password/change')
  Future<HttpResponse> postChangePassword(
    @Body() PasswordChangementOut passwordChangementOut,
  );
}
