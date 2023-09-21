import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/state/state/team_page_state.dart';

/// A StateNotifier class that manages the state of a list of TeamEntity objects
class TeamNotifier extends StateNotifier<TeamPageState> {
  final TeamRepository teamRepository;

  TeamNotifier(
    this.teamRepository,
  ) : super(
          TeamPageState(
            selectedTeamList: [],
            isValidationActivated: false,
          ),
        );

  void setSelectedTeamList(TeamModel team, bool selected) {
    if (!selected &&
        state.selectedTeamList
            .any((teamArg) => teamArg.teamId == team.teamId)) {
      state.selectedTeamList.remove(team);
    } else if (selected) {
      state.selectedTeamList.add(team);
    }

    if (state.selectedTeamList.isNotEmpty &&
        state.selectedTeamList.length < 3) {
      state = TeamPageState(
        selectedTeamList: state.selectedTeamList,
        isValidationActivated: true,
      );
    } else if (state.selectedTeamList.isEmpty ||
        state.selectedTeamList.length > 2) {
      state = TeamPageState(
        selectedTeamList: state.selectedTeamList,
        isValidationActivated: false,
      );
    }
  }

// DEPRECIATED (keep this function during migration)
  Future<void> fetchTeams() async {
    final teamList = await teamRepository.getTeam();
    debugPrint("teamList: $teamList");
  }
}
