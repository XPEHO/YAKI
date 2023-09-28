import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/icon_chip.dart';

class HeaderDeclarationSingleChoice extends StatelessWidget {
  final String declarationMode;
  final List<String> teamNameList;
  final String imageSrc = 'assets/images/onSite.svg';

  const HeaderDeclarationSingleChoice({
    super.key,
    required this.declarationMode,
    required this.teamNameList,
    required final String imageSrc,
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
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SvgPicture.asset(
                        imageSrc,
                        width: 50,
                        height: 50,
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
          ? "whenAreYouAbsent"
          : "whenDoYouWork"
      : "whereDoYouWork";
}

String setTeam({required List<String> teamList}) {
  return teamList.isNotEmpty ? teamList.first : "";
}
