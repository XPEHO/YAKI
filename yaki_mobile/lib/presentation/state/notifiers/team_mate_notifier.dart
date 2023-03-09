import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/team_mate_model.dart';

import 'package:yaki/data/repositories/team_mate_repository.dart';

class TeamMateNotifier extends StateNotifier<List<TeamMateModel?>> {
  final TeamMateRepository teamMateRepository;

  TeamMateNotifier(this.teamMateRepository)
      : super(
          [],
        );

  void setState(List<TeamMateModel?> maybeTeamList) {
    final List<TeamMateModel> teamList =
        maybeTeamList.whereType<TeamMateModel>().toList();

    state = teamList;
  }

  void fetchTeamMates() async {
    final nullsafetyTeamList = await teamMateRepository.getTeamMate();

    // receiving list<TeamMateModel?> and not a Futur<List<TeamMateMode?>>
    setState(nullsafetyTeamList);
  }
}

