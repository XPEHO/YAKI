import 'package:flutter/material.dart';
import 'package:yaki/data/sources/team_mate_api.dart';
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

  Future<List<TeamMateEntity>?> getTeamMate() async {
    try {
      final listTeamMateModel = await teamMateApi.getTeamMate();
      teamMatelist = listTeamMateModel.map((e) {
        return TeamMateEntity(
          user_firstname: e.user_first_name,
          user_lastName: e.user_last_name,
          declaration_date: e.declaration_date,
          declaration_status: e.declaration_status,
        );
      }).toList();
      return teamMatelist;
    } catch (e) {
      debugPrint('erreur dans le repo : $e');
      return [];
    }
  }
}
