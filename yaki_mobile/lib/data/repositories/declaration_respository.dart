import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;

  DeclarationRepository(this._declarationApi);

  Future<DeclarationModel> create(DeclarationModel declaration) async {
    print("create declaration method");
    final createdDeclaration = await _declarationApi.create(declaration);

    print("after return");
    print(createdDeclaration.toJson());

    return createdDeclaration;
  }
}
