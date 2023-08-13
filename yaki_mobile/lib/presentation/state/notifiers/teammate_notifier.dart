import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/data/repositories/teammate_repository.dart';
import 'package:yaki/domain/entities/teammate_entity.dart';

class TeammateNotifier extends StateNotifier<List<TeammateEntity>> {
  final TeammateRepository teammateRepository;

  final LoginRepository loginRepository;

  TeammateNotifier(this.teammateRepository, this.loginRepository)
      : super(
          [],
        );

  /// Retrieve the information from the team_mate_repository and store it in the state
  Future<void> fetchTeammates() async {
    final captainId = loginRepository.captainId.toString();
    final teamList = await teammateRepository.getTeammate(captainId);
    state = teamList;
  }
}
