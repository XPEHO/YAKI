import 'package:flutter/material.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class DeclarationHalfDayChoice extends StatelessWidget {
  final String declarationMode;
  final List<String> teamList;

  const DeclarationHalfDayChoice({
    super.key,
    required this.declarationMode,
    required this.teamList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "D'où travailles-tu ?",
          style: textStylePageTitle(),
        ),
        Row(
          children: [
            Text(
              "Pour ",
              style: textStylePageTitle(),
            ),
            Text(
              setTeam(
                teamList: teamList,
                declarationMode: declarationMode,
              ),
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
