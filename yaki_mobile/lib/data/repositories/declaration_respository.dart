import 'package:yaki/data/sources/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;

  DeclarationRepository(this._declarationApi);

  Future<DeclarationModel> create(DeclarationModel declaration) async {
    final createdDeclaration = await _declarationApi.create(declaration);
    return createdDeclaration;
  }
}