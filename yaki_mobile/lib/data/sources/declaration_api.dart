import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/declaration_model.dart';

part 'declaration_api.g.dart';

@RestApi()
abstract class DeclarationApi {
  factory DeclarationApi(Dio dio, {required String baseUrl}) = _DeclarationApi;

  @Headers("x-access-token": "test")
  @POST('/declarations')
  Future<DeclarationModel> create(@Body() DeclarationModel declaration);
}
