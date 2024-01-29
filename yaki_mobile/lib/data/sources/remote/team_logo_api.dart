import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'team_logo_api.g.dart';

@RestApi()
abstract class TeamLogoApi {
  factory TeamLogoApi(Dio dio, {required String baseUrl}) = _TeamLogoApi;

  @GET("/teams-logo")
  Future<HttpResponse> getTeamLogo(
    @Query('teamIds') String ids,
  );

  @GET("/teams-logo")
  Future<HttpResponse> getTeamLogoByUserId(
    @Query('userId') int userId,
  );
}
