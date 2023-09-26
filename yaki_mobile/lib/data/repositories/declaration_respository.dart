import 'package:flutter/cupertino.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/models/declaration_model_in.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/domain/entities/delcaration_entity_in.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;

  DeclarationRepository(
    this._declarationApi,
  );

  /// Invoked in declaration Notifier
  ///
  /// String statusValue used in authentication page :
  /// to determine if the response has a declaration object or not
  /// if statusValue is emptyString, there is no declaration at the current day, otherwise a declaration was created.
  ///
  /// invoke declarationApi.getDeclaration()
  /// Receive a HttpResponse, with :
  ///
  /// * HttpResponse.response, get the response statusCode
  /// * HttpResponse.data to get the data from the response body
  ///
  /// Depending of the response statusCode corresponding actions are set
  /// At statusCode 200 :
  /// * Convert the HttpResponse.data into a DeclarationModelIn instance,
  /// * Get the declarationStatus from the newly created object and assign it to the statusValue.
  ///
  /// This method return the statusValue value.
  Future<DeclarationEntityIn> getLatestDeclaration(int teamMateId) async {
    List<String> statusGetDecl = [];
    DateTime? dateStart;
    DateTime? dateEnd;

    try {
      final getHttpResponse = await _declarationApi.getDeclaration(teamMateId);
      final statusCode = getHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200:
          // if the server returns one declaration it means it's a declaration
          // for the whole day
          if (getHttpResponse.data.length == 1) {
            final getDeclarationIn = DeclarationModelIn.fromJson(
              getHttpResponse.data.first,
            );
            statusGetDecl.add(getDeclarationIn.declarationStatus);
            if (getDeclarationIn.declarationStatus == StatusEnum.absence.name) {
              dateStart = getDeclarationIn.declarationDateStart;
              dateEnd = getDeclarationIn.declarationDateEnd;
            }
          }
          // else the server returns at least two declarations
          else {
            final getDeclarationInMorning = DeclarationModelIn.fromJson(
              getHttpResponse.data[0],
            );
            final getDeclarationInAfternoon = DeclarationModelIn.fromJson(
              getHttpResponse.data[1],
            );
            statusGetDecl.add(getDeclarationInMorning.declarationStatus);
            statusGetDecl.add(getDeclarationInAfternoon.declarationStatus);
          }
          // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
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
    return DeclarationEntityIn(dateStart, dateEnd, statusGetDecl);
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
