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

          for (var i = 0; i < modelList.length; i++) {
            final TeammateWithDeclarationModel currentModel = modelList[i];
            // skip item if incorrect data
            if (currentModel.teamId == null || currentModel.userId == null) {
              debugPrint('Incorrect data from : $currentModel $i');
              continue;
            }

            //check if preview teammate is the same as the current one, meaning its a half day declaration
            if (i != 0 && modelList[i].userId == modelList[i - 1].userId) {
              final TeammateWithDeclarationEntity halfDayUser = entityList.last;

              halfDayUser.declarationStatusAfternoon = StatusEnum.fromValue(
                modelList[i].declarationStatus ?? StatusEnum.undeclared.name,
              );
              halfDayUser.teamIdAfternoon = modelList[i].teamId;
              halfDayUser.teamNameAfternoon =
                  teamNameCheck(modelList[i].teamName, i);
            } else {
              entityList.add(
                TeammateWithDeclarationEntity(
                  loggedUserId: userId,
                  userId: modelList[i].userId!,
                  userFirstName: modelList[i].userFirstName,
                  userLastName: modelList[i].userLastName,
                  declarationDate:
                      modelList[i].declarationDate ?? DateTime.now(),
                  declarationDateStart:
                      modelList[i].declarationDateStart ?? DateTime.now(),
                  declarationDateEnd:
                      modelList[i].declarationDateEnd ?? DateTime.now(),
                  declarationStatus: StatusEnum.fromValue(
                    modelList[i].declarationStatus ??
                        StatusEnum.undeclared.name,
                  ),
                  teamId: modelList[i].teamId!,
                  teamName: teamNameCheck(modelList[i].teamName, i),
                  declarationId: modelList[i].declarationId,
                  declarationUserId: modelList[i].declarationUserId,
                ),
              );
            }
          }
          return entityList;
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during teammate list get : $err');
      return [];
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

  String teamNameCheck(String? teamName, int index) {
    if (teamName == null || teamName == '') {
      return 'unknown $index';
    } else {
      return teamName;
    }
  }
}
