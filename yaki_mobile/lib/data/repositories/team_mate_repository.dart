import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/team_mate_model.dart';
import 'package:yaki/data/sources/remote/team_mate_api.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';

class TeamMateRepository {
  final TeamMateApi teamMateApi;
  List<TeamMateEntity> teamMatelist;
  TeamMateEntity? teamMateEntity;

  TeamMateRepository(
    this.teamMateApi, {
    this.teamMatelist = const [],
    this.teamMateEntity,
  });

  /// Retrieves information from the TeamMate API <br>
  /// and stores the response in the modelList variable
  Future<List<TeamMateEntity>> getTeamMate(String captainId) async {
    try {
      final listHttpResponse = await teamMateApi.getTeamMate(captainId);
      final statusCode = listHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          final modelList = setTeamMateModelList(listHttpResponse);

          List<TeamMateEntity> teamMatelist = <TeamMateEntity>[];

          for (var i = 0; i < modelList.length; i++) {
            final statusInCamelCase = StatusUtils.toCamelCase(
              toFormat: modelList[i].declarationStatus ?? 'undeclared',
              splitChar: ' ',
            );

            if (i != 0 && modelList[i].userId == modelList[i - 1].userId) {
              teamMatelist.last.addHalfDayDeclaration(statusInCamelCase);
            } else {
              teamMatelist.add(
                TeamMateEntity(
                  userFirstName: modelList[i].userFirstName,
                  userLastName: modelList[i].userLastName,
                  declarationDate: modelList[i].declarationDate,
                  declarationStatus: statusInCamelCase,
                ),
              );
            }
          }

          // modelList.map(
          //   (e) {
          //     final statusInCamelCase = StatusUtils.toCamelCase(
          //       toFormat: e.declarationStatus ?? 'undeclared',
          //       splitChar: ' ',
          //     );
          //     teamMatelist.add(
          //       TeamMateEntity(
          //         userFirstName: e.userFirstName,
          //         userLastName: e.userLastName,
          //         declarationDate: e.declarationDate,
          //         declarationStatus: statusInCamelCase,
          //       ),
          //     );
          //   },
          // ).toList();

          return teamMatelist;
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during teammate list get : $err');
      return [];
    }
  }

  /// Function converting httpResponse.data ( a List<dynamic> of Map ) into a
  /// List<TeamMateModel> using map, which create a List<dynamic> of TeamMateModel.
  /// Convert it afterward into a List<TeamMateModel>
  List<TeamMateModel> setTeamMateModelList(HttpResponse response) {
    final dynamicList = response.data.map(
      (teammate) {
        return TeamMateModel.fromJson(teammate);
      },
    ).toList();
    List<TeamMateModel> modelList = List<TeamMateModel>.from(dynamicList);
    return modelList;
  }
}
