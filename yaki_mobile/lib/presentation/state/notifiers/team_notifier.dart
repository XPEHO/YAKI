import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/data/repositories/login_repository.dart';

/// A StateNotifier class that manages the state of a list of TeamEntity objects
class TeamNotifier extends StateNotifier<List<TeamModel>> {
  // The repository that retrieves data from the API
  final TeamRepository teamRepository;
  // The repository that manages the user's login status
  final LoginRepository loginRepository;

  TeamNotifier(
    this.teamRepository,
    this.loginRepository,
  ) : super(
          [],
        );

  /// Asynchronous method that fetches a list of teams from the API and updates
  /// the state
  Future<void> fetchTeams() async {
    final teamList = await teamRepository.getTeam();
    state = teamList;
  }
}
