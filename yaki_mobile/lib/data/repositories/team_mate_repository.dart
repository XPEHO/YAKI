import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/team_mate_model.dart';
import 'package:yaki/data/sources/remote/team_mate_api.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';

class TeamMateRepository {
  final TeamMateApi teamMateApi;
  List<TeamMateEntity> teamMatelist;
  TeamMateEntity? teamMateEntity;

  TeamMateRepository(
    this.teamMateApi, {
    this.teamMatelist = const [],
    this.teamMateEntity,
  });

  Future<List<TeamMateEntity>> getTeamMate(String captainId) async {
    try {
      final listHttpResponse = await teamMateApi.getTeamMate(captainId);
      final modelList = setTeamMateModelList(listHttpResponse);

      teamMatelist = modelList.map(
        (e) {
          return TeamMateEntity(
            userFirstName: e.userFirstName,
            userLastName: e.userLastName,
            declarationDate: e.declarationDate,
            declarationStatus: e.declarationStatus,
          );
        },
      ).toList();
      return teamMatelist;
    } catch (e) {
      debugPrint('erreur dans le repo : $e');
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
