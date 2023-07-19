import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/user_registration_model.dart';

part 'user_register_repository.g.dart';

@RestApi()
abstract class UserRegisterRepository {
  factory UserRegisterRepository(Dio dio, {required String baseUrl}) =
      _UserRegisterRepository;

  @POST('/register')
  Future<HttpResponse> userResgistration(
    @Body() UserRegistrationModel userToRegiste,
  );
}
