import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/features/shared/team_logo_image.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/icon_chip.dart';

class HeaderDeclarationSingleChoice extends StatelessWidget {
  final String declarationMode;
  final List<String> teamNameList;
  final List<TeamModel> teamList;

  const HeaderDeclarationSingleChoice({
    super.key,
    required this.declarationMode,
    required this.teamNameList,
    required this.teamList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                tr(
                  setFirstSentence(
                    declarationMode: declarationMode,
                    teamNameList: teamNameList,
                  ),
                ),
                style: textStylePageTitle(),
              ),
            ),
          ],
        ),
        teamNameList.contains("Absence")
            ? Container()
            : Row(
                children: [
                  Text(
                    tr("for "),
                    style: textStylePageTitle(),
                  ),
                  IconChip(
                    label: setTeam(teamList: teamNameList),
                    backgroundColor: Colors.white,
                    borderWidth: 2,
                    fontSizeLabel: 20,
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: TeamLogoImage(
                        size: 32,
                        teamId: teamList.first.teamId,
                        teamName: teamList.first.teamName,
                      ),
                    ),
                  ),
                  Text(
                    " ?",
                    style: textStylePageTitle(),
                  ),
                ],
              ),
      ],
    );
  }
}

String setFirstSentence({
  required String declarationMode,
  required List<String> teamNameList,
}) {
  return declarationMode == DeclarationPaths.timeOfDay.text
      ? teamNameList.contains("Absence")
          ? tr('whenAreYouAbsent')
          : tr('whenDoYouWork')
      : tr('whereDoYouWork');
}

String setTeam({required List<String> teamList}) {
  return teamList.isNotEmpty ? teamList.first : "";
}
