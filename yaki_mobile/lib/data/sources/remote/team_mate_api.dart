import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'team_mate_api.g.dart';

@RestApi()
abstract class TeamMateApi {
  factory TeamMateApi(Dio dio, {required String baseUrl}) = _TeamMateApi;

  @GET('/teamMates')
  Future<HttpResponse> getTeamMate();
}
