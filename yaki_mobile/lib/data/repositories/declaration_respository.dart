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

    String statusValue = "";
    try {
      if ([200, 201].contains(statusCode)) {
        statusValue = httpResponse.data.declaration_status;
      } else if ([400, 500].contains(statusCode)) {
        statusValue = "nop";
        debugPrint("code error : $statusCode");
      }
    } catch (exception) {
      statusValue = "nop";
      debugPrint("error during creation $exception");
    }

    declarationStatus = DeclarationStatus(
      status: statusValue,
    );

    return statusCode;
  }

  String get status {
    return declarationStatus!.status;
  }
}
