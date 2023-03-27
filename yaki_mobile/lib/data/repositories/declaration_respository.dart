import 'package:flutter/cupertino.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/models/declaration_model_in.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;
  DeclarationStatus? declarationStatus;
  // inbetween {} are optional attributes
  // as long as they are nullable. no need to set them at class instantiation
  DeclarationRepository(
    this._declarationApi, {
    this.declarationStatus,
  });

  Future<String> getDeclaration(String teamMateId) async {
    String statusValue = "";
    try {
      final getHttpResponse = await _declarationApi.getDeclaration(teamMateId);
      final statusCode = getHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200:
          // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
          final getDeclarationIn = DeclarationModelIn.fromJson(
            getHttpResponse.data,
          );
          statusValue = getDeclarationIn.declarationStatus ?? "";
          break;
        case 404:
          debugPrint("No declaration for this day");
          break;
        default:
          throw Exception(
            "Invalid statusCode from server : ${getHttpResponse.response.statusCode}",
          );
      }
      setDeclarationEntities(statusValue);
    } catch (err) {
      debugPrint('error during get last declaration : $err');
    }
    return statusValue;
  }

  Future<void> create(DeclarationModel declaration) async {
    String statusValue = "";
    try {
      final createHttpResponse = await _declarationApi.create(declaration);
      final statusCode = createHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200 | 201:
          // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
          final createdDeclarationIn = DeclarationModelIn.fromJson(
            createHttpResponse.data,
          );
          statusValue = createdDeclarationIn.declarationStatus ?? "";
          break;
        case 400 | 500:
          debugPrint("Code error : $statusCode");
          break;
        case 401:
          debugPrint("Invalid token");
          break;
        case 403:
          debugPrint("Missing token in header : $statusCode");
          break;
        default:
          throw Exception(
            "Invalid statusCode from server : ${createHttpResponse.response.statusCode}",
          );
      }
      setDeclarationEntities(statusValue);
    } catch (err) {
      debugPrint("error during creation : $err");
    }
  }

  /// Assign status, to declarationStatus entities.
  void setDeclarationEntities(String status) {
    declarationStatus = DeclarationStatus(
      status: status,
    );
  }

  /// getter to retrieve declaration status stored in DeclarationStatus instance.
  String get status {
    return declarationStatus?.status ?? "";
  }
}
