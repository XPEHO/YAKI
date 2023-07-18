import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/user_registration_model.dart';

part 'register_repository.g.dart';

@RestApi()
abstract class RegisterRepository {
  factory RegisterRepository(Dio dio, {required String baseUrl}) = _RegisterRepository;

  @POST('/register')
  Future<HttpResponse> postLogin(@Body() UserRegistrationModel userToRegister);
}
