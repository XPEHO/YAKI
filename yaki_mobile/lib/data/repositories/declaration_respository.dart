import 'package:flutter/cupertino.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/models/declaration_model_in.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;

  DeclarationRepository(
    this._declarationApi,
  );

  Future<bool> getLatestDeclaration(int teamMateId) async {
    bool isAlreadyHaveDeclaration = false;
    try {
      final getHttpResponse = await _declarationApi.getDeclaration(teamMateId);
      final statusCode = getHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200:
          if (getHttpResponse.data.length == 1 ||
              getHttpResponse.data.length == 2) {
            isAlreadyHaveDeclaration = true;
          }
          if (getHttpResponse.data.length == 0) {
            isAlreadyHaveDeclaration = false;
          }
          break;
        case 404:
          debugPrint("No declaration for this day");
          break;
        default:
          throw Exception(
            "Invalid statusCode : $statusCode",
          );
      }
    } catch (err) {
      debugPrint('error during get last declaration : $err');
    }
    return isAlreadyHaveDeclaration;
  }

  /// Invoked in declaration Notifier
  ///
  /// String statusValue used in authentication page :
  /// to determine if the response has a declaration object or not
  /// if statusValue isn't emptyString, the declaration is successfully created.
  ///
  /// Receive a HttpResponse, with :
  /// * HttpResponse.response, get the response statusCode
  /// * HttpResponse.data to get the data from the response body
  ///
  /// Depending of the response statusCode corresponding actions are set
  ///
  /// * Convert the HttpResponse.data into a DeclarationModelIn instance,
  /// * Get the declarationStatus from created instance and assign it to the statusValue.
  ///
  /// At the end of the function assign the statusValue to the DeclarationStatus
  Future<String> createFullDay(DeclarationModel declaration) async {
    String statusFullDay = "";
    try {
      final createHttpResponse =
          await _declarationApi.create([declaration], StatusEnum.fullDay.value);
      final statusCode = createHttpResponse.response.statusCode;
      switch (statusCode) {
        case const (200 | 201):
          // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
          final createdDeclarationIn = DeclarationModelIn.fromJson(
            createHttpResponse.data.first,
          );
          statusFullDay = createdDeclarationIn.declarationStatus;
          break;
        case const (400 | 500):
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
    } catch (err) {
      debugPrint("error during creation : $err");
    }
    return statusFullDay;
  }

  Future<List<String>> createHalfDay(
    List<DeclarationModel> declarations,
  ) async {
    List<String> statusHalfDay = [];
    try {
      final createHttpResponse =
          await _declarationApi.create(declarations, StatusEnum.halfDay.value);
      final statusCode = createHttpResponse.response.statusCode;
      switch (statusCode) {
        case const (200 | 201):
          // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model
          // using .fromJson method
          final morningDeclaration = DeclarationModelIn.fromJson(
            createHttpResponse.data[0],
          );
          final afternoonDeclaration = DeclarationModelIn.fromJson(
            createHttpResponse.data[1],
          );
          statusHalfDay.add(morningDeclaration.declarationStatus);
          statusHalfDay.add(afternoonDeclaration.declarationStatus);
          break;
        case const (400 | 500):
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
    } catch (err) {
      debugPrint("error during creation : $err");
    }
    return statusHalfDay;
  }
}
