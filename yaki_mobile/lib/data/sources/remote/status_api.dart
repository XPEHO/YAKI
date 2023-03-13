import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/declaration_model.dart';

part 'status_api.g.dart';

@RestApi()
abstract class StatusApi {
  factory StatusApi(Dio dio, {required String baseUrl}) = _StatusApi;

  @GET('/status/{teamMateId}')
  Future<HttpResponse<DeclarationModel>> getDeclaration(
    @Path("teamMateId") String teamMateId,
  );
}
