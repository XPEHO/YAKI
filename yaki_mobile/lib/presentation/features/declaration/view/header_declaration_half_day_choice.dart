import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/domain/entities/chip_content.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
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
    final ChipContent chipContent = setChipContent(
      ref: ref,
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
              label: setTeam(
                teamList: teamNameList,
                declarationMode: declarationMode,
              ),
              backgroundColor: Colors.white,
              image: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SvgPicture.asset(
                  'assets/images/onSite.svg',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              tr(setHeaderText(ref, declarationMode)),
              style: textStylePageTitle(),
            ),
            IconChip(
              label: tr(chipContent.label),
              backgroundColor: Colors.white,
              image: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SvgPicture.asset(
                  chipContent.imageSrc,
                  width: 40,
                  height: 40,
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

String setHeaderText(WidgetRef ref, String declarationMode) {
  final selectedTimeOfDay =
      ref.watch(declarationProvider).teamsHalfDay.firstToDSelection;
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
  required WidgetRef ref,
  required String declarationMode,
}) {
  final selectedTimeOfDay =
      ref.watch(declarationProvider).teamsHalfDay.firstToDSelection;
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
