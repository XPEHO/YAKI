import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/state/providers/team_future_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamSelection extends ConsumerWidget {
  const TeamSelection({super.key});

  void onSelection({
    required ref,
    required bool isSelected,
    required TeamModel team,
  }) {
    ref.read(teamProvider.notifier).setSelectedTeamList(team, isSelected);
  }

  void onValidationTap({
    required WidgetRef ref,
    required BuildContext context,
    required bool isButtonActivated,
  }) {
    final selectCount = ref.read(teamProvider).selectedTeamList.length;

    if (isButtonActivated) {
      if (selectCount == 1) {
        context.go("/declaration");
      } else {
        context.go("/timeSelection");
      }
    }
    context.go("/declaration");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamListAsync = ref.watch(teamFutureProvider);
    final toDayDate = DateFormat('d MMMM y').format(DateTime.now());

    bool isValidationButtonEnabled =
        ref.watch(teamProvider).isValidationActivated;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20, 16.0, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toDayDate.toString(),
                      style: textStylePageDate(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      tr('teamSelectionPageTitle1'),
                      style: textStylePageTitle(),
                    ),
                    Text(
                      tr('teamSelectionPageTitle2'),
                      style: textStylePageTitle(),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      tr('teamSelectionPageHint'),
                      style: textStylePageHint(),
                    ),
                  ],
                ),
              ),
              asyncTeamListDisplay(teamListAsync, onSelection, ref),
              TeamSelectionCard(
                picture: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  child: SvgPicture.asset('assets/images/vacation.svg'),
                ),
                title: tr('vacation'),
                subtitle: tr('vacation'),
                onSelectionChanged: (bool selected) {
                  onSelection(
                    ref: ref,
                    isSelected: selected,
                    team: TeamModel(
                      teamId: -1,
                      teamName: "Away",
                      teamActifFlag: true,
                    ),
                  );
                },
              ),
              const Spacer(),
              Button(
                text: tr('buttonNext'),
                onPressed: () => onValidationTap(
                  ref: ref,
                  context: context,
                  isButtonActivated: isValidationButtonEnabled,
                ),
                color: isValidationButtonEnabled
                    ? const Color(0xFFFF936B)
                    : const Color.fromARGB(255, 195, 190, 190),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget asyncTeamListDisplay(
  AsyncValue<List<TeamModel>> teamListAsync,
  Function onSelection,
  WidgetRef ref,
) {
  return teamListAsync.when(
    data: (teamList) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: teamList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TeamSelectionCard(
              picture: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                child: SvgPicture.asset(
                  'assets/images/onSite.svg',
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
      );
    },
    error: (error, stackTrace) => const Text(""),
    loading: () => const Text(""),
  );
}
