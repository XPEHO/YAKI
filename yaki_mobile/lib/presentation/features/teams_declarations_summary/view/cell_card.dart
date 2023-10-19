import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_chips_row.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_iconchips.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class CellCard extends ConsumerWidget {
  final TeammateWithDeclarationEntity teammate;
  final bool isModifierBtnUsed;

  const CellCard({
    super.key,
    required this.teammate,
    required this.isModifierBtnUsed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Cell(
      title: '${teammate.userFirstName} ${teammate.userLastName}',
      subtitle: '',
      image: const CellAvatarSvg(
        imageSrc: "assets/images/Avatar.svg",
      ),
      chips: CellChipsRow(
        status: teammate.declarationStatus,
        statusAfternoon: teammate.declarationStatusAfternoon,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CellIconChips(
            teamName: teammate.teamName,
            status: teammate.declarationStatus,
            teamNameAfternoon: teammate.teamNameAfternoon,
            statusAfternoon: teammate.declarationStatusAfternoon,
          ),
          //display the button only if the modifier button is used
          if (isModifierBtnUsed)
            const SizedBox(
              height: 16,
            ),
          if (isModifierBtnUsed)
            Button.secondary(
              buttonHeight: 52,
              onPressed: () {
                ref.read(teamProvider.notifier).clearTeamList();
                context.go('/team-selection');
              },
              text: 'MODIFIER',
            ),
        ],
      ),
    );
  }
}

/// display the subtitle if the teammate has a declarationStatusAfternoon <br>
/// And if the declarationStatus is not undeclared or absence
bool isSubtitleDisplayed({
  required TeammateWithDeclarationEntity teammate,
}) =>
    teammate.declarationStatusAfternoon == null &&
            (teammate.declarationStatus == StatusEnum.undeclared ||
                teammate.declarationStatus == StatusEnum.absence)
        ? false
        : true;

/// display the time since the teammate has been declared based on the declarationDate
String displayTimeSinceDeclaration({
  required TeammateWithDeclarationEntity teammate,
}) {
  final now = DateTime.now();
  final declarationDate = teammate.declarationDate;
  final difference = now.difference(declarationDate);
  final differenceInHours = difference.inHours;
  final differenceInMinutes = difference.inMinutes;
  final differenceInSeconds = difference.inSeconds;

  if (differenceInHours > 0) {
    return '$differenceInHours h';
  } else if (differenceInMinutes > 0) {
    return '$differenceInMinutes min';
  } else if (differenceInSeconds > 0) {
    return '$differenceInSeconds sec';
  } else {
    return '0 sec';
  }
}
