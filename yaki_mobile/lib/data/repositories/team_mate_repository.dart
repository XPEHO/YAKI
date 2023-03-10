import 'package:flutter/material.dart';
import 'package:yaki/data/models/team_mate_model.dart';
import 'package:yaki/data/sources/team_mate_api.dart';

class TeamMateRepository {
  final TeamMateApi teamMateApi;

  TeamMateRepository(this.teamMateApi);

  Future<List<TeamMateModel>> getTeamMate() async {
    try {
      final listTeamMateModel = await teamMateApi.getTeamMate();
      debugPrint('Etat de la list dans le repo : $listTeamMateModel');
      return listTeamMateModel
          .map(
            (teamMate) => TeamMateModel(
              user_id: teamMate.user_id,
              user_last_name: teamMate.user_last_name,
              user_first_name: teamMate.user_first_name,
              user_email: teamMate.user_email,
              user_login: teamMate.user_login,
              user_password: teamMate.user_password,
              team_mate_id: teamMate.team_mate_id,
              team_mate_team_id: teamMate.team_mate_team_id,
              team_mate_user_id: teamMate.team_mate_user_id,
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('erreur dans le repo : $e');
      return [];
    }
  }
}
