import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/team_logo_model.dart';
import 'package:yaki/data/sources/remote/team_logo_api.dart';

class TeamLogoRepository {
  final TeamLogoApi _teamLogoApi;

  TeamLogoRepository(this._teamLogoApi);

  Future<List<TeamLogoModel>> getTeamsLogo(List<int> teamsIds) async {
    if (teamsIds.isEmpty) return [];
    String teamsIdsAsString = teamsIds.join(',');

    try {
      final listHttpResponse = await _teamLogoApi.getTeamLogo(teamsIdsAsString);
      final statusCode = listHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          return setTeamLogoModelList(listHttpResponse);
        case 404:
          return [];
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during password changement : $err');
    }
    return [];
  }

  Future<List<TeamLogoModel>> getTeamsLogoByUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt("userId");
      if (userId == null) {
        throw Exception('invalid user');
      }

      final listHttpResponse = await _teamLogoApi.getTeamLogoByUserId(userId);
      final statusCode = listHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          return setTeamLogoModelList(listHttpResponse);
        case 404:
          return [];
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during password changement : $err');
    }

    return [];
  }

  List<TeamLogoModel> setTeamLogoModelList(HttpResponse response) {
    if (response.data.isEmpty) return [];

    final List<TeamLogoModel> teamLogoList = [];
    for (final team in response.data) {
      if (team['teamLogoTeamId'] == null || team["teamLogoBlob"] == null) {
        continue;
      }
      teamLogoList.add(TeamLogoModel.fromJson(team));
    }
    return teamLogoList;
  }
}
