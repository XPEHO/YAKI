import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/declaration_model.dart';

part 'declaration_api.g.dart';

const baseUrl = 'http://192.168.1.116:3000/';

@RestApi(baseUrl: 'baseUrl')
abstract class DeclarationApi {
  factory DeclarationApi(Dio dio, {String baseUrl}) = _DeclarationApi;

  @POST('/declarations')
  Future<DeclarationModel> create(@Body() DeclarationModel declaration);
}