import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/declaration_model.dart';

part 'declaration_api.g.dart';

@RestApi()
abstract class DeclarationController {
  factory DeclarationController(Dio dio, {required String baseUrl}) = _DeclarationController;

  @POST('/declarations')
  Future<DeclarationModel> create(@Body() DeclarationModel declaration);
}
