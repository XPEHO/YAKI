import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/features/team_selection/view/team_selection_header.dart';
import 'package:yaki/presentation/features/team_selection/view/team_selection_list.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamSelection extends ConsumerWidget {
  const TeamSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isValidationButtonEnabled = ref.watch(teamProvider).isButtonActivated;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20, 16.0, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TeamSelectionHeader(),
              const TeamSelectionList(),
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

void onValidationTap({
  required WidgetRef ref,
  required BuildContext context,
  required bool isButtonActivated,
}) {
  final selectCount = ref.read(teamProvider).selectedTeamList.length;

  if (isButtonActivated) {
    if (selectCount == 1) {
      //For new logic change to "/declaration/${DeclarationPaths.fullDay.text}"
      //context.go("/declaration");
      context.go("/declaration/${DeclarationPaths.fullDay.text}");
    } else if (selectCount == 2) {
      ref.read(teamProvider.notifier).isAbsenceSelectedSetFirstOfList();
      //For new logic change to "/declaration/${DeclarationPaths.timeOfDay.text}"
      //context.go("/morningDeclaration");
      context.go("/declaration/${DeclarationPaths.timeOfDay.text}");
    }
  }
}
