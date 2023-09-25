import 'package:flutter/material.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class DeclarationSingleChoice extends StatelessWidget {
  final String declarationMode;
  final List<String> teamList;

  const DeclarationSingleChoice({
    super.key,
    required this.declarationMode,
    required this.teamList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              setFirstWord(declarationMode: declarationMode),
              style: textStylePageTitle(),
            ),
            Text(
              "travailles-tu",
              style: textStylePageTitle(),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "pour ",
              style: textStylePageTitle(),
            ),
            Text(
              setTeam(teamList: teamList),
              style: textStylePageTitle(),
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

String setFirstWord({required String declarationMode}) {
  return declarationMode == DeclarationPaths.timeOfDay.text
      ? "Quand "
      : "D'où ";
}

String setTeam({required List<String> teamList}) {
  return teamList.isNotEmpty ? teamList.first : "";
}
