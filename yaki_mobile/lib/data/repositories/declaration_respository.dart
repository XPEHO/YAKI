import 'package:flutter/cupertino.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;
  DeclarationStatus? declarationStatus;

  DeclarationRepository(this._declarationApi);

  /// Invoke DeclarationAPI to POST a declaration.
  /// await for the API answer to retreive the reponse status code.
  /// Used to generate the statusValue, saved into a DeclarationStatus instance.
  Future<int?> create(DeclarationModel declaration) async {
    final httpResponse = await _declarationApi.create(declaration);
    final statusCode = httpResponse.response.statusCode;

    String statusValue = generateStatusValue(statusCode, httpResponse.data.declaration_status);
    declarationStatus = DeclarationStatus(
      status: statusValue,
    );
    return statusCode;
  }

  /// generate statusValue based on HttpResponse status code,
  /// coming from Declaration creation
  String generateStatusValue(int? statusCode, String httpResponseStatus) {
    String statusValue = "";
    try {
      if ([200, 201].contains(statusCode)) {
        statusValue = httpResponseStatus;
      } else if ([400, 500].contains(statusCode)) {
        statusValue = "";
        debugPrint("code error : $statusCode");
      }
    } catch (exception) {
      statusValue = "";
      debugPrint("error during creation $exception");
    }
    return statusValue;
  }

  /// getter to retrieve declaration status stored in DeclarationStatus instance.
  String get status {
    return declarationStatus!.status;
  }
}
