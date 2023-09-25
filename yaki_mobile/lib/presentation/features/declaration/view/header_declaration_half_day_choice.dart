import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/icon_chip.dart';

class HeaderDeclarationHalfDayChoice extends ConsumerWidget {
  final String declarationMode;
  final List<String> teamList;
  final String imageSrc;

  const HeaderDeclarationHalfDayChoice({
    super.key,
    required this.declarationMode,
    required this.teamList,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('whereworking'),
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
                teamList: teamList,
                declarationMode: declarationMode,
              ),
              backgroundColor: Colors.white,
              image: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SvgPicture.asset(
                  'assets/images/onSite.svg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              tr(setThis(ref, declarationMode)),
              style: textStylePageTitle(),
            ),
            IconChip(
              label: tr(setLabel(ref, declarationMode)),
              backgroundColor: Colors.white,
              image: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SvgPicture.asset(
                  setImageChips(ref, declarationMode),
                  width: 50,
                  height: 50,
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

String setImageChips(WidgetRef ref, String declarationMode) {
  final todStatus =
      ref.watch(declarationProvider).teamsHalfDay.firstToDSelection;
  final isMorning = todStatus == StatusEnum.morning;
  final image = isMorning
      ? "assets/images/Time-Morning.svg"
      : "assets/images/Time-Afternoon.svg";
  return declarationMode == DeclarationPaths.halfDayStart.text ? image : image;
}

String setLabel(WidgetRef ref, String declarationMode) {
  final selectedTimeOfDay =
      ref.watch(declarationProvider).teamsHalfDay.firstToDSelection;
  String toReturn = "";
  declarationMode == DeclarationPaths.halfDayStart.text &&
          selectedTimeOfDay == StatusEnum.morning
      ? toReturn = "morning"
      : toReturn = "afternoon";
  declarationMode == DeclarationPaths.halfDayEnd.text &&
          selectedTimeOfDay == StatusEnum.morning
      ? toReturn = "afternoon"
      : toReturn = "morning";
  return toReturn;
}

String setThis(WidgetRef ref, String declarationMode) {
  final selectedTimeOfDay =
      ref.watch(declarationProvider).teamsHalfDay.firstToDSelection;
  String toReturn = "";
  declarationMode == DeclarationPaths.halfDayStart.text &&
          selectedTimeOfDay == StatusEnum.morning
      ? toReturn = "thisMorning"
      : toReturn = "thisAfternoon";
  declarationMode == DeclarationPaths.halfDayEnd.text &&
          selectedTimeOfDay == StatusEnum.morning
      ? toReturn = "thisAfternoon"
      : toReturn = "thisMorning";
  return toReturn;
}
