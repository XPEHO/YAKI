import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';
import 'package:yaki/presentation/displaydata/avatar_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_collapsed_chips_row.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_opened_iconchips.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
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
      subtitle: teammate.declarationDate != null
          ? timeSinceDeclaration(teammate.declarationDate!)
          : '',
      image: setUserAvatarImage(
        ref: ref,
        isModifierBtnUsed: isModifierBtnUsed,
        teammate: teammate,
      ),
      chips: CellCollapsedChipsRow(
        teamId: teammate.teamId,
        teamName: teammate.teamName,
        status: teammate.declarationStatus,
        teamIdAfternoon: teammate.teamIdAfternoon,
        teamNameAfternoon: teammate.teamNameAfternoon,
        statusAfternoon: teammate.declarationStatusAfternoon,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CellOpenedIconChips(
            teamId: teammate.teamId,
            teamName: teammate.teamName,
            status: teammate.declarationStatus,
            teamIdAfternoon: teammate.teamIdAfternoon,
            teamNameAfternoon: teammate.teamNameAfternoon,
            statusAfternoon: teammate.declarationStatusAfternoon,
          ),
          //display the button only if the modifier button is used
          if (isModifierBtnUsed) ...[
            const SizedBox(
              height: 16,
            ),
            Button.secondary(
              buttonHeight: 52,
              onPressed: () {
                ref.read(teamProvider.notifier).clearTeamList();
                context.go('/team-selection');
              },
              text: 'MODIFIER',
            ),
          ],
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

String timeSinceDeclaration(DateTime declarationDate) {
  final duration = DateTime.now().difference(declarationDate);
  if (duration.inDays > 0) {
    return '${duration.inDays} days ago';
  } else if (duration.inHours > 0) {
    return '${duration.inHours} hours ago';
  } else if (duration.inMinutes > 0) {
    return '${duration.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}

Widget setUserAvatarImage({
  required WidgetRef ref,
  required bool isModifierBtnUsed,
  required TeammateWithDeclarationEntity teammate,
}) {
  String firstName = "A";
  String lastName = "B";
  String? avatarReference;
  Uint8List? avatar;

  final avatarData = ref.watch(avatarProvider);

  if (isModifierBtnUsed) {
    avatar = avatarData.avatar;
    avatarReference = avatarData.avatarReference;
  } else {
    avatarReference = teammate.avatarReference;
    avatar = teammate.avatar;
  }

  firstName = teammate.userFirstName;
  lastName = teammate.userLastName;

  String firstLestters =
      '${firstName.isNotEmpty ? firstName[0] : "A"}${lastName.isNotEmpty ? lastName[0] : "B"}';

  if (avatarReference != null &&
      AvatarEnum.defaultAvatars.contains(avatarReference)) {
    return CellAvatarSvg(
      imageSrc: AvatarEnum.values.byName(avatarReference).text,
    );
  } else if (avatar != null) {
    return CellAvatarImg(
      imageAvatar: avatar,
    );
  }
  return CellAvatarLetters(userFirstLetters: firstLestters);
}
