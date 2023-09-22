import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/state/providers/team_future_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki_ui/team_selection_card.dart';

class TeamSelectionList extends ConsumerWidget {
  const TeamSelectionList({super.key});

  void onSelection({
    required ref,
    required bool isSelected,
    required TeamModel team,
  }) {
    ref.read(teamProvider.notifier).setSelectedTeamList(team, isSelected);
  }

  //temporary : TeamModel should contain a pictoLink
  String pictoLink(TeamModel team) {
    final picto = team.teamName == "Absence"
        ? 'assets/images/vacation.svg'
        : 'assets/images/onSite.svg';
    return picto;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamListAsync = ref.watch(teamFutureProvider);

    return teamListAsync.when(
      data: (teamList) {
        return Expanded(
          child: ListView.builder(
            itemCount: teamList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TeamSelectionCard(
                  picture: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    child: SvgPicture.asset(
                      pictoLink(teamList[index]),
                    ),
                  ),
                  title: 'Project',
                  subtitle: teamList[index].teamName ?? 'No team name',
                  onSelectionChanged: (bool selected) {
                    final teamId = teamList[index].teamId;
                    if (teamId != null) {
                      onSelection(
                        ref: ref,
                        isSelected: selected,
                        team: teamList[index],
                      );
                    }
                  },
                ),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => const Text(""),
      loading: () => const Text(""),
    );
  }
}
