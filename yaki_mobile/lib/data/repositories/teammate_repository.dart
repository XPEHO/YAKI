import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/teammate_model.dart';
import 'package:yaki/data/sources/remote/teammate_api.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';

class TeammateRepository {
  final TeammateApi teammateApi;
  List<TeammateEntity> teammatelist;
  TeammateEntity? teamMateEntity;

  TeammateRepository(
    this.teammateApi, {
    this.teammatelist = const [],
    this.teamMateEntity,
  });

  /// Retrieves information from the TeamMate API <br>
  /// and stores the response in the modelList variable
  Future<List<TeammateEntity>> getTeammate(String captainId) async {
    try {
      final listHttpResponse = await teammateApi.getTeammate(captainId);
      final statusCode = listHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          final modelList = setTeammateModelList(listHttpResponse);

          List<TeammateEntity> teammatelist = <TeammateEntity>[];

          for (var i = 0; i < modelList.length; i++) {
            final statusInCamelCase = StatusUtils.toCamelCase(
              toFormat: modelList[i].declarationStatus ?? 'undeclared',
            );

            if (i != 0 && modelList[i].userId == modelList[i - 1].userId) {
              teammatelist.last.addHalfDayDeclaration(statusInCamelCase);
            } else {
              teammatelist.add(
                TeammateEntity(
                  userFirstName: modelList[i].userFirstName,
                  userLastName: modelList[i].userLastName,
                  declarationDate: modelList[i].declarationDate,
                  declarationStatus: statusInCamelCase,
                ),
              );
            }
          }

          return teammatelist;
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during teammate list get : $err');
      return [];
    }
  }

  /// Function converting httpResponse.data ( a List<dynamic> of Map ) into a
  /// List<TeammateModel> using map, which create a List<dynamic> of TeammateModel.
  /// Convert it afterward into a List<TeammateModel>
  List<TeammateModel> setTeammateModelList(HttpResponse response) {
    final dynamicList = response.data.map(
      (teammate) {
        return TeammateModel.fromJson(teammate);
      },
    ).toList();
    List<TeammateModel> modelList = List<TeammateModel>.from(dynamicList);
    return modelList;
  }
}
