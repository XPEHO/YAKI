import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/teammate_with_declaration_model.dart';
import 'package:yaki/data/sources/remote/teammate_api.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

class TeammateRepository {
  final TeammateApi teammateApi;

  TeammateRepository(
    this.teammateApi,
  );

  /// Retrieves information from the Teammate API <br>
  /// and stores the response in the modelList variable
  Future<List<TeammateWithDeclarationEntity>> getTeammate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt("userId");
      if (userId == null) {
        throw Exception('invalid user');
      }

      final listHttpResponse = await teammateApi.getTeammate(userId);
      final statusCode = listHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          final List<TeammateWithDeclarationModel> modelList =
              setTeammateWithDeclaModelList(listHttpResponse);

          List<TeammateWithDeclarationEntity> entityList =
              <TeammateWithDeclarationEntity>[];

          // Create the list of TeammateWithDeclarationEntity
          for (var i = 0; i < modelList.length; i++) {
            final TeammateWithDeclarationModel currentModel = modelList[i];

            // skip item if necessary data is incorrect
            if (currentModel.userId == null ||
                currentModel.declarationStatus != null &&
                    currentModel.declarationStatus != StatusEnum.absence.name &&
                    currentModel.teamId == null) {
              debugPrint('Incorrect data from : $currentModel $i');
              continue;
            }

            // If preview teammate is the same as the current one, meaning "current" is the afternoon declaration part
            if (i != 0 && currentModel.userId == modelList[i - 1].userId) {
              final TeammateWithDeclarationEntity halfDayUser = entityList.last;

              halfDayUser.declarationStatusAfternoon = StatusEnum.fromValue(
                currentModel.declarationStatus!,
              );
              halfDayUser.teamIdAfternoon = currentModel.teamId;
              halfDayUser.teamNameAfternoon = currentModel.teamName;
              halfDayUser.customerAfternoonId = currentModel.customerId;
              halfDayUser.customerAfternoonName = currentModel.customerName;
            } else {
              entityList.add(
                TeammateWithDeclarationEntity(
                  loggedUserId: userId,
                  userId: currentModel.userId!,
                  userFirstName: currentModel.userFirstName!,
                  userLastName: currentModel.userLastName!,
                  declarationDate: currentModel.declarationDate,
                  declarationDateStart: currentModel.declarationDateStart,
                  declarationDateEnd: currentModel.declarationDateEnd,
                  declarationStatus: StatusEnum.fromValue(
                    currentModel.declarationStatus ??
                        StatusEnum.undeclared.name,
                  ),
                  teamId: currentModel.teamId,
                  teamName: currentModel.teamName,
                  customerId: currentModel.customerId,
                  customerName: currentModel.customerName,
                ),
              );
            }
          }
          return entityList;
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      return Future.error(Exception('Error during teammate list fetch'));
    }
  }

  /// Helper method that parses the API response data and returns a list of
  /// TeammateModel objects
  List<TeammateWithDeclarationModel> setTeammateWithDeclaModelList(
    HttpResponse response,
  ) {
    final List<TeammateWithDeclarationModel> modelList = [];
    for (final teammateAndDeclaration in response.data) {
      modelList
          .add(TeammateWithDeclarationModel.fromJson(teammateAndDeclaration));
    }
    return modelList;
  }
}
