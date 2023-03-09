import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;
  late final bool isFetchSuccess;

  DeclarationRepository(this._declarationApi);

  Future<bool> create(DeclarationModel declaration) async {
    try {
      final createResponse = await _declarationApi.create(declaration);
      final statusCode = createResponse.response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        isFetchSuccess = true;
      } else if (statusCode == 500) {
        isFetchSuccess = false;
      }
    } catch(exception) {
      debugPrint("error during creation $exception");
    }

    return isFetchSuccess;
  }
}
