import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/teammate_with_declaration_model.dart';
import 'package:yaki/data/sources/remote/teammate_api.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/state/state/team_page_state.dart';

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
          // If the response is OK, parse the JSON to a list of TeammateModel
          final List<TeammateWithDeclarationModel> modelList =
              setTeammateWithDeclaModelList(listHttpResponse);

          List<TeammateWithDeclarationEntity> entityList =
              <TeammateWithDeclarationEntity>[];

          // Create the list of TeammateWithDeclarationEntity
          for (var i = 0; i < modelList.length; i++) {
            final TeammateWithDeclarationModel currentModel = modelList[i];

            // skip item if necessary data is incorrect
            if (isDataIncorrect(currentModel: currentModel)) {
              debugPrint('Incorrect data from : $currentModel $i');
              continue;
            }

            if (isAfternoonDeclaration(
              i: i,
              currentModel: currentModel,
              modelList: modelList,
            )) {
              updateLatestTeammateEntityAfternoonDeclaration(
                entityList: entityList,
                currentModel: currentModel,
              );
            } else {
              addNewTeammateEntityToTheList(
                entityList: entityList,
                currentModel: currentModel,
                userId: userId,
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

  /// Check if the data from the API is correct
  /// * if there is no userId the data can't be correct, as we look to retrive a teammateDeclaration
  /// Or
  /// * if the declarationStatus is not null and not equal to absence while the teamId is null the data can't be correct.
  /// Meaning that the user has declaration but without team data, which is incorrect.
  ///
  /// If all the data is correct, continue to the next step.
  /// If not, skip the item
  bool isDataIncorrect({required TeammateWithDeclarationModel currentModel}) {
    return currentModel.userId == null ||
        (currentModel.declarationStatus != null &&
            currentModel.declarationStatus != StatusEnum.absence.name &&
            currentModel.teamId == null);
  }

  /// Add a new teammate to the entityList
  void addNewTeammateEntityToTheList({
    required List<TeammateWithDeclarationEntity> entityList,
    required TeammateWithDeclarationModel currentModel,
    required int userId,
  }) {
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
          currentModel.declarationStatus ?? StatusEnum.undeclared.name,
        ),
        teamId: currentModel.teamId ?? absenceTeamId,
        teamName: currentModel.teamName ?? 'absence',
        customerId: currentModel.customerId,
        customerName: currentModel.customerName,
        avatarReference: currentModel.avatarReference,
        avatar: currentModel.avatarByteArray != null
            ? Uint8List.fromList(
                (currentModel.avatarByteArray!.cast<int>()),
              )
            : null,
      ),
    );
  }

  /// If preview teammate is the same as the current one,
  /// meaning "current" as a half day declaration,
  bool isAfternoonDeclaration({
    required int i,
    required TeammateWithDeclarationModel currentModel,
    required List<TeammateWithDeclarationModel> modelList,
  }) {
    return i != 0 && currentModel.userId == modelList[i - 1].userId;
  }

  /// Update the afternoon declaration part of the current teammate.
  /// After the isAfternoonDeclaration() method has been called.
  /// and returned true.
  /// retrive the latest entity added to the entityList, to update the afternoon declaration part.
  void updateLatestTeammateEntityAfternoonDeclaration({
    required List<TeammateWithDeclarationEntity> entityList,
    required TeammateWithDeclarationModel currentModel,
  }) {
    final TeammateWithDeclarationEntity halfDayUser = entityList.last;

    halfDayUser.declarationStatusAfternoon = StatusEnum.fromValue(
      currentModel.declarationStatus!,
    );
    halfDayUser.teamIdAfternoon = currentModel.teamId ?? absenceTeamId;
    halfDayUser.teamNameAfternoon = currentModel.teamName;
    halfDayUser.customerAfternoonId = currentModel.customerId;
    halfDayUser.customerAfternoonName = currentModel.customerName;
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
