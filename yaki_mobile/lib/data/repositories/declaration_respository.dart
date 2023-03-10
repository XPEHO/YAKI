import 'package:flutter/cupertino.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;

  DeclarationRepository(this._declarationApi);

  DeclarationStatus? declarationStatus;

  Future<int?> create(DeclarationModel declaration) async {
    final httpResponse = await _declarationApi.create(declaration);
    final statusCode = httpResponse.response.statusCode;

    try {
      if ([200, 201].contains(statusCode)) {
        declarationStatus = DeclarationStatus(
          status: httpResponse.data.declaration_status,
        );
      } else if ([400, 500].contains(statusCode)) {
        debugPrint("code error : $statusCode");
      }
    } catch (exception) {
      debugPrint("error during creation $exception");
    }
    return statusCode;
  }

  String get status {
    String result;
    declarationStatus != null
        ? result = declarationStatus!.status
        : result = "nop";
    return result;
  }
}
