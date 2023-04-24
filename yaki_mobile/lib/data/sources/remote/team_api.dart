import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'team_api.g.dart';

@RestApi()
abstract class TeamApi {
  factory TeamApi(Dio dio, {required String baseUrl}) = _TeamApi;

  @GET('/teams')
  Future<HttpResponse> getTeam(
    @Query('teamMateId') String id,
  );
}
