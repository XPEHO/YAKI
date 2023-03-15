import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/declaration_model_in.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;
  DeclarationStatus? declarationStatus;

  DeclarationRepository(this._declarationApi);

  Future<String> getDeclaration(String teamMateId) async {
    String status = "";
    try {
      final lastDeclaration = await _declarationApi.getDeclaration(teamMateId);
      final statusCode = lastDeclaration.response.statusCode;

      switch (statusCode) {
        case 200:
          status = lastDeclaration.data!.declarationStatus!;
          break;
        case 404:
          debugPrint("No declaration for this day");
          break;
        default:
          throw Exception(lastDeclaration.response.statusMessage);
      }
      declarationStatus = DeclarationStatus(
        status: lastDeclaration.data!.declarationStatus!,
      );
      return status;
    } catch (err) {
      debugPrint('$err');
    }
    return status;
  }

  Future<void> create(DeclarationModel declaration) async {
    final declarationResponse = await _declarationApi.create(declaration);

    String statusValue = handleDeclarationStatus(declarationResponse);
    declarationStatus = DeclarationStatus(
      status: statusValue,
    );
  }

  /// generate statusValue based on HttpResponse status code,
  /// coming from Declaration creation
  String handleDeclarationStatus(HttpResponse<DeclarationModelIn> response) {
    String statusValue = "";
    try {
      final statusCode = response.response.statusCode;
      switch (statusCode) {
        case 200 | 201:
          statusValue = response.data.declarationStatus!;
          break;
        case 400 | 500:
          debugPrint("code error : $statusCode");
          break;
        case 401:
          debugPrint(" invalid token");
          break;
        case 403:
          debugPrint("missing token in header : $statusCode");
          break;
        default:
          throw Exception(response.response.statusMessage);
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
