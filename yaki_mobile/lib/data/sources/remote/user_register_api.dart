import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/user_registration_model.dart';

part 'user_register_api.g.dart';

@RestApi()
abstract class UserRegisterApi {
  factory UserRegisterApi(Dio dio, {required String baseUrl}) =
      _UserRegisterApi;

  @POST('/register')
  Future<HttpResponse> userResgistration(
    @Body() UserRegistrationModel userToRegiste,
  );
}
