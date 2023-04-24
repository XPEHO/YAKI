import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/domain/entities/team_entity.dart';
import 'package:yaki/data/repositories/login_repository.dart';

class TeamNotifier extends StateNotifier<List<TeamEntity>> {
  final TeamRepository teamRepository;
  final LoginRepository loginRepository;

  TeamNotifier(
    this.teamRepository,
    this.loginRepository,
  ) : super(
          [],
        );

  Future<void> fetchTeams() async {
    final teamMateId = loginRepository.teamMateId.toString();
    final teamList = await teamRepository.getTeam(teamMateId);
    state = teamList;
    print('teamNotifier, $teamList');
  }
}
