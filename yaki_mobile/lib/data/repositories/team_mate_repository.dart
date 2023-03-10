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
              team_mate_id: teamMate.team_mate_id,
              user_id: teamMate.user_id,
              team_id: teamMate.team_id,
              last_name: teamMate.last_name,
              first_name: teamMate.first_name,
              email: teamMate.email,
              token: teamMate.token,
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('erreur dans le repo : $e');
      return [];
    }
  }
}
