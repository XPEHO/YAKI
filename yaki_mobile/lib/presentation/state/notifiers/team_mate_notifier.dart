import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_mate_repository.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';

class TeamMateNotifier extends StateNotifier<List<TeamMateEntity>> {
  final TeamMateRepository teamMateRepository;

  TeamMateNotifier(this.teamMateRepository)
      : super(
          [],
        );

  Future<void> fetchTeamMates() async {
    final teamList = await teamMateRepository.getTeamMate();
    state = teamList;
  }
}
