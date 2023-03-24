import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/data/repositories/team_mate_repository.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';

class TeamMateNotifier extends StateNotifier<List<TeamMateEntity>> {
  final TeamMateRepository teamMateRepository;

  final LoginRepository loginRepository;

  TeamMateNotifier(this.teamMateRepository, this.loginRepository)
      : super(
          [],
        );

  Future<void> fetchTeamMates() async {
    final captainId = loginRepository.captainId.toString();
    final teamList = await teamMateRepository.getTeamMate(captainId);
    state = teamList;
  }
}
