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
            isButtonActivated: false,
          ),
        );

  /// when a team card is pressed, it save the selected team in the state,
  /// or remove it if it is already in the list and the card is pressed again.(unselected).
  ///
  /// if the list is empty or has more than 2 teams, the button is deactivated.
  void setSelectedTeamList(TeamModel selectedTeam, bool isCardPressed) {
    final isTeamInList = state.selectedTeamList
        .any((teamSearch) => teamSearch.teamId == selectedTeam.teamId);

    if (!isCardPressed && isTeamInList) {
      state.selectedTeamList.remove(selectedTeam);
    } else if (isCardPressed) {
      state.selectedTeamList.add(selectedTeam);
    }

    if (state.selectedTeamList.isNotEmpty &&
        state.selectedTeamList.length < 3) {
      state = TeamPageState(
        selectedTeamList: state.selectedTeamList,
        isButtonActivated: true,
      );
    } else if (state.selectedTeamList.isEmpty ||
        state.selectedTeamList.length > 2) {
      state = TeamPageState(
        selectedTeamList: state.selectedTeamList,
        isButtonActivated: false,
      );
    }
  }

  /// invoked when team button validation is pressed, and if there is 2 teams selected.
  /// If "Absence" is selected and not the first of the list, it is moved to the first position.
  void isAbsenceSelectedSetFirstOfList() {
    final bool isAbsenceSelected = state.selectedTeamList
        .any((teamSearch) => teamSearch.teamName == "Absence");

    if (isAbsenceSelected &&
        state.selectedTeamList.first.teamName != "Absence") {
      state.selectedTeamList = state.selectedTeamList.reversed.toList();
    }

    for (final team in state.selectedTeamList) {
      debugPrint("team: ${team.teamName}");
    }
  }

// DEPRECIATED (keep this function during migration)
  Future<void> fetchTeams() async {
    final teamList = await teamRepository.getTeam();
    debugPrint("teamList: $teamList");
  }
}
