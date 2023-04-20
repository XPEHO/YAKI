import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

import 'package:yaki/data/sources/remote/team_api.dart';

import '../../domain/entities/team_entity.dart';
import '../models/team_model.dart';

class TeamRepository {
  final TeamApi teamApi;
  List<TeamEntity> teamlist;
  TeamEntity? teamEntity;

  TeamRepository(
     this.teamApi, {
     this.teamlist = const [],
     this.teamEntity,
  });

  Future<List<TeamEntity>> getTeam(String teamMateId) async {
    try {
      final listHttpResponse = await teamApi.getTeam(teamMateId);
      print(listHttpResponse);
      final statusCode = listHttpResponse.statusCode;

      switch (statusCode) {
        case 200:
          final modelList = setTeamModelList(listHttpResponse as HttpResponse);

          teamlist = modelList.map(
                (e) {
              return TeamEntity(
                teamId: e.teamId,
                teamName: e.teamName,
              );
            },
          ).toList();
          return teamlist;
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during team list get : $err');
      return [];
    }
  }

  List<TeamModel> setTeamModelList(HttpResponse response) {
    final dynamicList = response.data.map(
          (team) {
        return TeamModel.fromJson(team);
      },
    ).toList();
    List<TeamModel> modelList = List<TeamModel>.from(dynamicList);
    return modelList;
  }
}
