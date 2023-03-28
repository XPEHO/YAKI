import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'team_mate_api.g.dart';

@RestApi()
abstract class TeamMateApi {
  /// Establishes the connection to the database using the baseUrl address<br>
  /// set in the environment variables (see team_mate_provider.dart)
  factory TeamMateApi(Dio dio, {required String baseUrl}) = _TeamMateApi;

  /// Establishes a connection to the "/TeamMate" route and <br>
  /// retrieves the informations by registering it in the "getTeamMate()" function
  /// -> Sending to the Repository
  @GET('/teamMates')
  Future<HttpResponse> getTeamMate(
    @Query('captainId') String id,
  );
}
