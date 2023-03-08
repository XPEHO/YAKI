import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:yaki/data/models/team_mate_model.dart';

part 'team_mate_api.g.dart';

@RestApi()
abstract class TeamMateApi {
  factory TeamMateApi(Dio dio, {required String baseUrl}) = _TeamMateApi;

  @GET('/teammates')
  Future<List<TeamMateModel?>> getTeamMate();

}