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

  Future<List<TeamMateEntity>> getTeamMate() async {
    try {
      final listTeamMateModel = await teamMateApi.getTeamMate();
      teamMatelist = listTeamMateModel.map((e) {
        return TeamMateEntity(
          userFirstName: e.userFirstName,
          userLastName: e.userLastName,
          declarationDate: e.declarationDate,
          declarationStatus: e.declarationStatus,
        );
      }).toList();
      return teamMatelist;
    } catch (e) {
      debugPrint('erreur dans le repo : $e');
      return [];
    }
  }
}
