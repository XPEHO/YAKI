import 'package:flutter/cupertino.dart';
import 'package:yaki/data/models/declaration_model_in.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;
  DeclarationStatus? declarationStatus;
  String? statusValue = "";
  String? nullStatusValue = "";

  // inbetween {} are optional attributes
  // as long as they are nullable. no need to set them at class instantiation
  DeclarationRepository(
    this._declarationApi, {
    this.declarationStatus,
    this.statusValue,
    this.nullStatusValue,
  });

  Future<String> getDeclaration(String teamMateId) async {
    try {
      final getHttpResponse = await _declarationApi.getDeclaration(teamMateId);
      // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
      final getDeclarationIn = DeclarationModelIn.fromJson(
        getHttpResponse.data,
      );

      final statusCode = getHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200:
          // null check "??" mean, if left is null, set right value
          statusValue = getDeclarationIn.declarationStatus ?? nullStatusValue;
          break;
        case 404:
          debugPrint("No declaration for this day");
          break;
        default:
          throw Exception(getHttpResponse.response.statusMessage);
      }
      setDeclarationEntities(statusValue!);
    } catch (err) {
      debugPrint('error during get last declaration : $err');
    }
    return statusValue!;
  }

  Future<void> create(DeclarationModel declaration) async {
    try {
      final createHttpResponse = await _declarationApi.create(declaration);
      // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
      final createdDeclarationIn = DeclarationModelIn.fromJson(
        createHttpResponse.data,
      );

      final statusCode = createHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200 | 201:
          statusValue =
              createdDeclarationIn.declarationStatus ?? nullStatusValue;
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
          throw Exception(createHttpResponse.response.statusMessage);
      }
      setDeclarationEntities(statusValue!);
    } catch (exception) {
      debugPrint("error during creation : $exception");
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
    return declarationStatus!.status;
  }
}
