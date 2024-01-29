import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/state/providers/team_logo_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';

final teamFutureProvider = FutureProvider.autoDispose<List<TeamModel>>((ref) {
  final teamRepo = ref.watch(teamRepositoryProvider);

  final Future<List<TeamModel>> teamList = teamRepo.getTeam().then(
    (list) {
      // save fetched team list in state
      if (list.isNotEmpty) {
        ref.read(teamProvider.notifier).setFetchedTeamList(list);

        List<int> teamIds = list.map((e) => e.teamId).toList();

        ref.read(teamLogoProvider.notifier).getTeamLogo(teamIds);
      }

      return [
        ...list,
        TeamModel(
          teamId: -1,
          teamName: "Absence",
          teamActifFlag: true,
        ),
      ];
    },
  );

  return teamList;
});
