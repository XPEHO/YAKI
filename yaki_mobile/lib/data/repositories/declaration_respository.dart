import 'package:flutter/cupertino.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/models/declaration_model_in.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';

class DeclarationRepository {
  final DeclarationApi _declarationApi;
  DeclarationStatus declarationStatus = DeclarationStatus();
  // inbetween {} are optional attributes
  // as long as they are nullable. no need to set them at class instantiation
  DeclarationRepository(
    this._declarationApi,
  );

  /// Invoked in declaration Notifier
  ///
  /// String statusValue used in authentication page :
  ///
  /// to determine if the response has a declaration object or not
  /// if statusValue is emptyString, there is no declaration at the current day, otherwise a declaration was created.
  ///
  /// invoke declarationApi.getDeclaration() method to GET the declaration for the selected teammate
  /// Receive a HttpResponse, with :
  ///
  /// * HttpResponse.response, get the response statusCode
  ///
  /// * HttpResponse.data to get the data from the response body
  ///
  /// Depending of the response statusCode corresponding actions are set
  ///
  /// ( for now, only actions at statusCode 200 are made, waiting to setup analytic to be set up for others error code)
  ///
  /// At statusCode 200 :
  /// * Convert the HttpResponse.data into a DeclarationModelIn instance,
  /// * Get the declarationStatus from the newly created object and assign it to the statusValue.
  ///
  /// This method return the statusValue value.
  Future<String> getDeclaration(String teamMateId) async {
    String statusValue = "";
    try {
      final getHttpResponse = await _declarationApi.getDeclaration(teamMateId);
      final statusCode = getHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200:
          // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
          final getDeclarationIn = DeclarationModelIn.fromJson(
            getHttpResponse.data.first,
          );
          statusValue = getDeclarationIn.declarationStatus;
          break;
        case 404:
          debugPrint("No declaration for this day");
          break;
        default:
          throw Exception(
            "Invalid statusCode : $statusCode",
          );
      }
      setAllDayDeclaration(statusValue);
    } catch (err) {
      debugPrint('error during get last declaration : $err');
    }
    return statusValue;
  }

  /// Invoked in declaration Notifier
  ///
  /// String statusValue used in authentication page :
  /// to determine if the response has a declaration object or not
  /// if statusValue isn't emptyString, the declaration is successfully created.
  ///
  /// Receive a HttpResponse, with :
  ///
  /// * HttpResponse.response, get the response statusCode
  ///
  /// * HttpResponse.data to get the data from the response body
  ///
  /// Depending of the response statusCode corresponding actions are set
  ///
  /// ( for now, only actions at statusCode 200 or 201 are made, waiting to setup analytic to be set up for others error code)
  /// * Convert the HttpResponse.data into a DeclarationModelIn instance,
  /// * Get the declarationStatus from created instance and assign it to the statusValue.
  ///
  /// At the end of the function assign the statusValue to the DeclarationStatus
  Future<void> createAllDay(DeclarationModel declaration) async {
    String statusValue = "";
    try {
      final createHttpResponse =
          await _declarationApi.create([declaration], StatusEnum.fullDay.text);
      final statusCode = createHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200 | 201:
          // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
          final createdDeclarationIn = DeclarationModelIn.fromJson(
            createHttpResponse.data.first,
          );
          statusValue = createdDeclarationIn.declarationStatus;
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
      setAllDayDeclaration(statusValue);
    } catch (err) {
      debugPrint("error during creation : $err");
    }
  }

  Future<void> createHalfDay(List<DeclarationModel> declarations) async {
    String statusValueMorning = "";
    String statusValueAfternoon = "";
    try {
      final createHttpResponse =
          await _declarationApi.create(declarations, StatusEnum.halfDay.text);
      final statusCode = createHttpResponse.response.statusCode;
      switch (statusCode) {
        case 200 | 201:
          // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model
          // using .fromJson method
          final createdDeclarationInMorning = DeclarationModelIn.fromJson(
            createHttpResponse.data[0],
          );
          final createdDeclarationInAfternoon = DeclarationModelIn.fromJson(
            createHttpResponse.data[1],
          );
          statusValueMorning = createdDeclarationInMorning.declarationStatus;
          statusValueAfternoon =
              createdDeclarationInAfternoon.declarationStatus;
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
      setHalfDayDeclaration(statusValueMorning, statusValueAfternoon);
    } catch (err) {
      debugPrint("error during creation : $err");
    }
  }

  /// Assign status, to declarationStatus entities.
  void setAllDayDeclaration(String status) {
    declarationStatus.allDayDeclaration = status;
  }

  /// Assign status, to declarationStatus entities.
  void setHalfDayDeclaration(String morningStatus, String afternoonStatus) {
    declarationStatus.morningDeclaration = morningStatus;
    declarationStatus.afternoonDeclaration = afternoonStatus;
  }

  /// Assign status, to declarationStatus entities.
  void setMorningDeclaration(String status) {
    declarationStatus.morningDeclaration = status;
  }

  /// getter to retrieve declaration status stored in DeclarationStatus instance.
  /// This getter is called in the status_notifier, this value will determine the status page content.
  String get statusAllDay {
    return declarationStatus.allDayDeclaration;
  }

  String get statusMorning {
    return declarationStatus.morningDeclaration;
  }

  DeclarationStatus get allDeclarations {
    return declarationStatus;
  }
}
