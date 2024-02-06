import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/team_logo_model.dart';
import 'package:yaki/data/repositories/team_logo_repository.dart';
import 'package:yaki/domain/entities/team_logo_entity.dart';

class TeamLogoNotifier extends StateNotifier<List<TeamLogoEntity>> {
  TeamLogoRepository teamLogoRepository;

  TeamLogoNotifier({required this.teamLogoRepository})
      : super(
          [
            //default value used in teammate_future_provider
            //and determnine if the team logo still hasn't be fetched
            TeamLogoEntity(
              teamId: -1,
              teamLogo: Uint8List.fromList([0]),
            ),
          ],
        );

  Future<void> getTeamLogo(List<int> teamsIds) async {
    final List<TeamLogoModel> teamLogoList =
        await teamLogoRepository.getTeamsLogo(teamsIds);

    // change default notifier value to not trigger the fetch in the teammmate_future_provider
    if (teamLogoList.isEmpty) state = [];

    setTeamLogoList(teamLogoList);
  }

  Future<void> getTeamsLogoByUserId() async {
    final List<TeamLogoModel> teamLogoList =
        await teamLogoRepository.getTeamsLogoByUserId();

    if (teamLogoList.isEmpty) return;

    setTeamLogoList(teamLogoList);
  }

  void setTeamLogoList(List<TeamLogoModel> teamLogoModelList) {
    state = teamLogoModelList
        .map(
          (teamLogoModel) => TeamLogoEntity(
            teamId: teamLogoModel.teamLogoTeamId,
            teamLogo: Uint8List.fromList(teamLogoModel.teamLogoBlob.data),
          ),
        )
        .toList();
  }
}
