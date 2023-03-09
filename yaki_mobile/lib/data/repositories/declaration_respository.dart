import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;
  late final bool isFetchSuccess;

  DeclarationRepository(this._declarationApi);

  void create(DeclarationModel declaration) async {
    final createDeclaResponse = await _declarationApi.create(declaration);
    final statusCode = createDeclaResponse.response.statusCode;

    statusCodeManagement(statusCode!);
  }

  bool statusCodeManagement(int statusCode) {
    try {
      if (statusCode == 201 || statusCode == 200) {
        isFetchSuccess = true;
      } else if (statusCode == 500) {
        isFetchSuccess = false;
      }
    } catch (exception) {
      debugPrint("error during creation $exception");
    }

    return isFetchSuccess;
  }
}
