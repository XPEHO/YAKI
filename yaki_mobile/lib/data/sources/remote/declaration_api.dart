import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/declaration_model.dart';

part 'declaration_api.g.dart';

@RestApi()
abstract class DeclarationApi {
  factory DeclarationApi(Dio dio, {required String baseUrl}) = _DeclarationApi;

  @GET('/declarations')
  Future<HttpResponse> getDeclaration(
    @Query("teamMateId") String id,
  );

  @POST('/declarations?mode="fullDay"')
  Future<HttpResponse> createAllDayDeclaration(
    @Body() DeclarationModel declaration,
  );

  @POST('/declarations?mode="halfDay"')
  Future<HttpResponse> createHalfdayDeclaration(
    @Body() List<DeclarationModel> declaration,
  );
}
