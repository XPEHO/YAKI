import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_summary_enum.dart';
import 'package:yaki/presentation/features/shared/app_bar_date.dart';
import 'package:yaki/presentation/features/team_selection/view/team_selection_header.dart';
import 'package:yaki/presentation/features/team_selection/view/team_selection_list.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/state/providers/user_provider.dart';
import 'package:yaki/presentation/ui/vacation/vacation_selection_dialog.dart';
import 'package:yaki_ui/yaki_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamSelection extends ConsumerWidget {
  const TeamSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isValidationButtonEnabled = ref.watch(teamProvider).isButtonActivated;

    return Scaffold(
      appBar: AppBarWithDate(
        actions: <Widget>[
          IconButton(
            icon: const NavIconCircleAvatar(
              imageSrc: 'assets/images/Account.svg',
            ),
            onPressed: () {
              ref.read(userProvider.notifier).getUser();
              ref.read(avatarProvider.notifier).getAvatar();
              context.go('/profile/fromTeamSelection');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8, 16.0, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TeamSelectionHeader(),
              const Expanded(
                child: TeamSelectionList(),
              ),
              Button(
                text: tr('buttonNext').toUpperCase(),
                buttonHeight: 64,
                onPressed: () => onValidationTap(
                  ref: ref,
                  context: context,
                  isButtonActivated: isValidationButtonEnabled,
                ),
                color: isValidationButtonEnabled
                    ? const Color(0xFFFF936B)
                    : const Color.fromARGB(255, 195, 190, 190),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

void onValidationTap({
  required WidgetRef ref,
  required BuildContext context,
  required bool isButtonActivated,
}) {
  // do nothing if button isnt activated
  if (!isButtonActivated) return;

  final teamList = ref.read(teamProvider).selectedTeamList;
  final selectCount = teamList.length;

  final fetchedTeamList = ref.read(teamProvider).fetchedTeamList;

  if (selectCount == 1) {
    final bool isAbsenceSelected =
        teamList.any((team) => team.teamName == "Absence");

    if (isAbsenceSelected) {
      // get first team with valid teamId
      final int selectedTeamId = fetchedTeamList
          .firstWhere(
            (team) => team.teamId > 0,
            orElse: () => fetchedTeamList.first,
          )
          .teamId;

      VacationSelectionDialog(
        teamId: selectedTeamId,
        ref: ref,
        context: context,
        goToPage: () =>
            context.go('/summary/${DeclarationSummaryPaths.absence.text}'),
      ).show();
    } else {
      context.go("/declaration/${DeclarationPaths.fullDay.text}");
    }
  } else if (selectCount == 2) {
    ref.read(teamProvider.notifier).isAbsenceSelectedSetFirstOfList();

    context.go("/declaration/${DeclarationPaths.timeOfDay.text}");
  }
}
