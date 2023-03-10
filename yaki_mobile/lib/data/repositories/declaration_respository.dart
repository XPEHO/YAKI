import 'package:flutter/cupertino.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;

  DeclarationRepository(this._declarationApi);

  DeclarationStatus? declarationStatus;

  void create(DeclarationModel declaration) async {
    final httpResponse = await _declarationApi.create(declaration);

    final statusCode = httpResponse.response.statusCode;
    try {
      if (statusCode == 201 || statusCode == 200) {
        declarationStatus = DeclarationStatus(
          status: httpResponse.data.declaration_status,
        );
      } else if (statusCode == 400) {
        debugPrint("code error : $statusCode");
      }
    } catch (exception) {
      debugPrint("error during creation $exception");
    }
  }

  String get status {
    String result;
    declarationStatus != null
        ? result = declarationStatus!.status
        : result = "";
    return result;
  }
}
