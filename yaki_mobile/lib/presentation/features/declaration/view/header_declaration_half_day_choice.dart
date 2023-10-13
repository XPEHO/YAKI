import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/chip_content.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/icon_chip.dart';

class HeaderDeclarationHalfDayChoice extends ConsumerWidget {
  final String declarationMode;
  final List<String> teamNameList;
  final String imageSrc;

  const HeaderDeclarationHalfDayChoice({
    super.key,
    required this.declarationMode,
    required this.teamNameList,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StatusEnum selectedTimeOfDay =
        ref.read(declarationProvider).halfDayWorkflow.firstToDSelection;

    final String teamName = setTeam(
      teamList: teamNameList,
      declarationMode: declarationMode,
    );

    final String headerText = setHeaderText(
      selectedTimeOfDay: selectedTimeOfDay,
      declarationMode: declarationMode,
    );

    final ChipContent chipContent = setChipContent(
      selectedTimeOfDay: selectedTimeOfDay,
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
                child: const UserDeclarationChipSvgPicture(
                  imageSrc: 'assets/images/onSite.svg',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              tr(headerText),
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

String setTeam({
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

String setHeaderText({
  required StatusEnum selectedTimeOfDay,
  required String declarationMode,
}) {
  final isMorning = selectedTimeOfDay == StatusEnum.morning;
  return declarationMode == DeclarationPaths.halfDayStart.text
      ? isMorning
          ? "thisMorning"
          : "thisAfternoon"
      : isMorning
          ? "thisAfternoon"
          : "thisMorning";
}

ChipContent setChipContent({
  required StatusEnum selectedTimeOfDay,
  required String declarationMode,
}) {
  final isMorning = selectedTimeOfDay == StatusEnum.morning;
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
