import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/team_mate_model.dart';

import 'package:yaki/data/repositories/team_mate_repository.dart';

class TeamMateNotifier extends StateNotifier<List<TeamMateModel?>> {
  final TeamMateRepository teamMateRepository;

  TeamMateNotifier(this.teamMateRepository)
      : super(
          [],
        );

  // void getTeamMate() async {
  //   final teamMatesList = await teamMateRepository.getTeamMate();
  //   state = teamMatesList;
  //   //return teamMatesList;
  // }

  void fetchTeamMates() async {
    final teamMatesList = await teamMateRepository.getTeamMate();
    state = teamMatesList;
  }


}
