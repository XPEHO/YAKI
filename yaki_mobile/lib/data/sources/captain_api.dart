import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/captain_model.dart';

part 'captain_api.g.dart';

@RestApi()
abstract class CaptainApi {
  factory CaptainApi(Dio dio, {required String baseUrl}) = _CaptainApi;

  @GET('/captains')
  Future<CaptainModel> getCaptain();
}