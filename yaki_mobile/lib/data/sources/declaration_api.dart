import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/declaration_model.dart';

part 'declaration_api.g.dart';

@RestApi()
abstract class DeclarationApi {
  factory DeclarationApi(Dio dio, {required String baseUrl}) = _DeclarationApi;

  @POST('/declarations')
  Future<DeclarationModel> create(@Body() DeclarationModel declaration);
}
