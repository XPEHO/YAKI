import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/domain/entities/chip_content.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/shared/team_logo_image.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/icon_chip.dart';

class HeaderDeclarationHalfDayChoice extends ConsumerWidget {
  final String declarationMode;
  final List<String> teamNameList;
  final List<TeamModel> teamList;

  const HeaderDeclarationHalfDayChoice({
    super.key,
    required this.declarationMode,
    required this.teamNameList,
    required this.teamList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StatusEnum firstTimeOfDaySelected =
        ref.read(declarationProvider).halfDayWorkflow.firstToDSelection;

    final int teamId = setTeamId(
      teamList: teamList,
      declarationMode: declarationMode,
    );

    final String teamName = setTeamName(
      teamList: teamNameList,
      declarationMode: declarationMode,
    );

    final String headerTimeOfDayText = setTimeOfDayText(
      firstSelectedTimeOfDay: firstTimeOfDaySelected,
      declarationMode: declarationMode,
    );

    final ChipContent chipContent = setChipContent(
      firstSelectedTimeOfDay: firstTimeOfDaySelected,
      declarationMode: declarationMode,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('whereDoYouWork'),
          style: textStylePageTitle(),
        ),
        Row(
          children: [
            Text(
              tr('for '),
              style: textStylePageTitle(),
            ),
            IconChip(
              label: teamName,
              backgroundColor: Colors.white,
              borderWidth: 2,
              fontSizeLabel: 20,
              image: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: TeamLogoImage(
                  size: 32,
                  teamId: teamId,
                  teamName: teamName,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              tr(headerTimeOfDayText),
              style: textStylePageTitle(),
            ),
            IconChip(
              label: tr(chipContent.label),
              backgroundColor: Colors.white,
              borderWidth: 2,
              fontSizeLabel: 20,
              image: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: UserDeclarationChipSvgPicture(
                  imageSrc: chipContent.imageSrc,
                ),
              ),
            ),
            Text(
              (" ?"),
              style: textStylePageTitle(),
            ),
          ],
        ),
      ],
    );
  }
}

/// Returns the name of the team to display in the header of the declaration page
/// Depending of the declaration mode (current half day step) return the first or the last team of the list
String setTeamName({
  required List<String> teamList,
  required String declarationMode,
}) {
  if (teamList.isEmpty) return "";

  return declarationMode == DeclarationPaths.halfDayStart.text
      ? teamList.first
      : declarationMode == DeclarationPaths.halfDayEnd.text
          ? teamList.last
          : "";
}

/// Returns the id of the team used to determine the team logo to display in the header of the declaration page
int setTeamId({
  required List<TeamModel> teamList,
  required String declarationMode,
}) {
  if (teamList.isEmpty) return 0;

  return declarationMode == DeclarationPaths.halfDayStart.text
      ? teamList.first.teamId
      : declarationMode == DeclarationPaths.halfDayEnd.text
          ? teamList.last.teamId
          : 0;
}

/// Returns the text to display in the header of the declaration page
/// Compare the first moment of the day selected  by the user to the TimeOfDay page, and the current declaration mode (current half day step)
String setTimeOfDayText({
  required StatusEnum firstSelectedTimeOfDay,
  required String declarationMode,
}) {
  final isMorning = firstSelectedTimeOfDay == StatusEnum.morning;
  return declarationMode == DeclarationPaths.halfDayStart.text
      ? isMorning
          ? "thisMorning"
          : "thisAfternoon"
      : isMorning
          ? "thisAfternoon"
          : "thisMorning";
}

ChipContent setChipContent({
  required StatusEnum firstSelectedTimeOfDay,
  required String declarationMode,
}) {
  final isMorning = firstSelectedTimeOfDay == StatusEnum.morning;
  return declarationMode == DeclarationPaths.halfDayStart.text
      ? isMorning
          ? ChipContent(
              imageSrc: 'assets/images/Time-Morning.svg',
              label: "morning",
            )
          : ChipContent(
              imageSrc: 'assets/images/Time-Afternoon.svg',
              label: "afternoon",
            )
      : isMorning
          ? ChipContent(
              imageSrc: 'assets/images/Time-Afternoon.svg',
              label: "afternoon",
            )
          : ChipContent(
              imageSrc: 'assets/images/Time-Morning.svg',
              label: "morning",
            );
}
