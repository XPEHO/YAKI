import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/presentation/state/state/team_page_state.dart';

/// A StateNotifier class that manages the state of a list of TeamEntity objects
class TeamNotifier extends StateNotifier<TeamPageState> {
  TeamRepository teamRepository;

  TeamNotifier({required this.teamRepository})
      : super(
          TeamPageState(
            fetchedTeamList: [], // saved from team_future_provider.dart
            selectedTeamList: [], // teams selected by the user from the team_selection_list.dart
            isButtonActivated: false,
          ),
        );

  void setFetchedTeamList(List<TeamModel> fetchedTeamList) {
    state = state.copyWith(fetchedTeamList: fetchedTeamList);
  }

  /// when a team card is pressed, it save the selected team in the state,
  /// or remove it if it is already in the list and the card is pressed again.(unselected).
  ///
  /// if the list is empty or has more than 2 teams, the button is deactivated.
  void setSelectedTeamList(TeamModel selectedTeam, bool isCardPressed) {
    final isTeamInList = state.selectedTeamList.any(
      (teamSearch) => teamSearch.teamId == selectedTeam.teamId,
    );

    if (isCardPressed) {
      state.selectedTeamList.add(selectedTeam);
    } else if (isTeamInList) {
      // cardPress false and in list, remove
      state.selectedTeamList.remove(selectedTeam);
    }

    if (state.selectedTeamList.isNotEmpty &&
        state.selectedTeamList.length < 3) {
      state = state.copyWith(isButtonActivated: true);
    } else {
      state = state.copyWith(isButtonActivated: false);
    }
  }

  /// invoked when team button validation is pressed, and if there is 2 teams selected.
  /// If "Absence" is selected and not the first of the list, it is moved to the first position.
  void isAbsenceSelectedSetFirstOfList() {
    final bool isAbsenceSelected = state.selectedTeamList
        .any((teamSearch) => teamSearch.teamName == "Absence");

    if (!isAbsenceSelected) return;

    if (state.selectedTeamList.first.teamName != "Absence") {
      state.selectedTeamList = state.selectedTeamList.reversed.toList();
    }
  }

  /// Empty the list of selected teams and deactivate the button.
  void clearTeamList() {
    state = state.copyWith(
      selectedTeamList: [],
      isButtonActivated: false,
    );
  }

  /// Asynchronous method that retrieves a list of teams from the API and
  Future<void> getUserTeamList() async {
    List<TeamModel> userTeamList = await teamRepository.getTeam();

    state = state.copyWith(fetchedTeamList: userTeamList);
  }

  /// Determines if the teamName is in the list of teams fetched from the API.
  /// Used in the CellOpenedIconChips and CellCollapsedChipsRow widgets.
  /// (features/teams_declarations_summary/view/...)
  bool isTeamBelowToCurrentUser({
    required String teamName,
  }) {
    bool isTeamBelowToCurrentUser =
        state.fetchedTeamList.any((team) => team.teamName == teamName);

    return isTeamBelowToCurrentUser;
  }
}
