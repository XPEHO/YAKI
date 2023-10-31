import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  /// Establishes the connection to the database using the baseUrl address<br>
  /// set in the environment variables (see user_provider.dart)
  factory UserApi(Dio dio, {required String baseUrl}) = _UserApi;

  /// Establishes a connection to the "/User" route and <br>
  /// retrieves the informations by registering it in the "getUserById()" function
  /// -> Sending to the Repository
  @GET('/users/{userId}')
  Future<HttpResponse> getUserById(
    @Path('userId') int id,
  );
}
