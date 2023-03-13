import 'package:flutter/cupertino.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;
  DeclarationStatus? declarationStatus;

  DeclarationRepository(this._declarationApi);

  Future<int?> getDeclaration(String teamMateId) async {
    print("DECLA REPO GETTER ");
    final lastDeclaration = await _declarationApi.getDeclaration(teamMateId);
    final statusCode = lastDeclaration.response.statusCode;

    print('decla repo GET :  $statusCode');
    print(
        'decla repo GET : status : ${lastDeclaration.data!.declarationStatus}');

    if (statusCode == 200) {
      declarationStatus = DeclarationStatus(
        status: lastDeclaration.data!.declarationStatus!,
      );
    }
    return statusCode;
  }

  /// Invoke DeclarationAPI to POST a declaration.
  /// await for the API answer to retrieve the response status code.
  /// Used to generate the statusValue, saved into a DeclarationStatus instance.
  /// This DeclarationStatus instance will be used to
  Future<void> create(DeclarationModel declaration) async {
    final httpResponse = await _declarationApi.create(declaration);
    final statusCode = httpResponse.response.statusCode;

    String statusValue = generateStatusValue(
      statusCode,
      httpResponse.data.declarationStatus,
    );
    declarationStatus = DeclarationStatus(
      status: statusValue,
    );
  }

  /// generate statusValue based on HttpResponse status code,
  /// coming from Declaration creation
  String generateStatusValue(int? statusCode, String? httpResponseStatus) {
    String statusValue = "";
    try {
      if ([200, 201].contains(statusCode)) {
        statusValue = httpResponseStatus!;
      } else if ([400, 500].contains(statusCode)) {
        debugPrint("code error : $statusCode");
      } else if (statusCode == 401) {
        debugPrint(" invalid token");
      } else if (statusCode == 403) {
        debugPrint("missing token in header : $statusCode");
      }
    } catch (exception) {
      debugPrint("error during creation $exception");
    }
    return statusValue;
  }

  /// getter to retrieve declaration status stored in DeclarationStatus instance.
  String get status {
    return declarationStatus!.status;
  }
}
