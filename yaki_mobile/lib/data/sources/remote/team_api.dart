
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'team_api.g.dart';

@RestApi()
abstract class TeamApi {

  factory TeamApi(Dio dio, {required String baseUrl}) = _TeamApi;

  @GET('/team')
  Future<HttpResponse> getTeam(
      @Query('teamMateId') String id,
      );
}