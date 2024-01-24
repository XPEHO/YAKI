import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/features/shared/custom_circular_progress_indicator.dart';
import 'package:yaki/presentation/features/shared/something_went_wrong.dart';
import 'package:yaki/presentation/state/providers/team_future_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki_ui/team_selection_card.dart';

class TeamSelectionList extends ConsumerWidget {
  const TeamSelectionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var teamListAsync = ref.watch(teamFutureProvider);

    return teamListAsync.when(
      data: (teamList) {
        // save fetched team list in state
        if (teamList.isNotEmpty) {
          ref.read(teamProvider).fetchedTeamList = teamList;
        }

        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(),
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              teamListAsync = await ref.refresh(teamFutureProvider);
            },
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
                    title: tr("project"),
                    subtitle: teamList[index].teamName,
                    onSelectionChanged: (bool selected) {
                      onSelection(
                        ref: ref,
                        isSelected: selected,
                        team: teamList[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
      error: (error, stackTrace) => FailToFetchDataList(
        onPressed: () async =>
            teamListAsync = await ref.refresh(teamFutureProvider),
      ),
      loading: () => const Center(
        child: CustomCircularProgressIndicator(),
      ),
    );
  }
}

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
      ? 'assets/images/absent.svg'
      : 'assets/images/Logo-Team.svg';
  return picto;
}
