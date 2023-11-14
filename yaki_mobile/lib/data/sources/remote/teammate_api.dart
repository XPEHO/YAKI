import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'teammate_api.g.dart';

@RestApi()
abstract class TeammateApi {
  /// Establishes the connection to the database using the baseUrl address<br>
  /// set in the environment variables (see team_mate_provider.dart)
  factory TeammateApi(Dio dio, {required String baseUrl}) = _TeammateApi;

  /// Establishes a connection to the "/TeamMate" route and <br>
  /// retrieves the informations by registering it in the "getTeamMate()" function
  /// -> Sending to the Repository
  @GET('/users-declaration-and-avatar')
  Future<HttpResponse> getTeammate(
    @Query('userId') int id,
  );
}
