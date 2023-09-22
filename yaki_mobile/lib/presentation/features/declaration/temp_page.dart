import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/features/declaration/view/declaration_half_day_choice.dart';
import 'package:yaki/presentation/features/declaration/view/declaration_single_choice.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';

class TempDeclarationPage extends ConsumerWidget {
  final String declarationMode;

  const TempDeclarationPage({
    super.key,
    required this.declarationMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TeamModel> teamList = ref.read(teamProvider).selectedTeamList;

    final List<String> teamNameList;

    if (teamList.isNotEmpty) {
      teamNameList = teamList.map((e) => e.teamName ?? "default name").toList();
    } else {
      teamNameList = [""];
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                declarationMode,
                style: textStylePageHint(),
              ),
              Text(
                teamNameList.isNotEmpty ? teamNameList.toString() : "",
                style: textStylePageHint(),
              ),
              const SizedBox(height: 60),
              setHeader(declarationMode, teamNameList),
              const SizedBox(height: 60),
              Button(
                text: setButtonsText(declarationMode).first,
                onPressed: () => onButtonPress(ref),
                color: const Color.fromARGB(255, 119, 160, 191),
              ),
              const SizedBox(height: 10),
              Button(
                text: setButtonsText(declarationMode).last,
                onPressed: () => onButtonPress(ref),
                color: const Color.fromARGB(255, 119, 160, 191),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void onButtonPress(WidgetRef ref) {
  ref.read(declarationProvider.notifier).declarationCreationHandler();
}

/// Determine the buttons's text depending of the declarationMode.
/// Only the declarationMode "time-of-day" have different buttons text.
/// For the halfDay we start by selecting the moment of the day (morning or afternoon)
List<String> setButtonsText(String declarationMode) {
  List<String> buttonsText = ["", ""];

  if (declarationMode == DeclarationPaths.timeOfDay.text) {
    buttonsText = ["matin", "après-midi"];
  } else if (declarationMode == DeclarationPaths.fullDay.text ||
      declarationMode == DeclarationPaths.halfDayStart.text ||
      declarationMode == DeclarationPaths.halfDayEnd.text) {
    buttonsText = ["Sur site", "Distanciel"];
  }

  return buttonsText;
}

/// Depending of the declarationMode, Display a different widget
/// Time of day and fullday have similar Widget with a different title.
/// Halfday first and second choice have similar title with team + time of day information.
Widget setHeader(String declarationMode, List<String> teamList) {
  if (declarationMode == DeclarationPaths.fullDay.text ||
      declarationMode == DeclarationPaths.timeOfDay.text) {
    return DeclarationSingleChoice(
      declarationMode: declarationMode,
      teamList: teamList,
    );
  } else if (declarationMode == DeclarationPaths.halfDayStart.text ||
      declarationMode == DeclarationPaths.halfDayEnd.text) {
    return DeclarationHalfDayChoice(
      declarationMode: declarationMode,
      teamList: teamList,
    );
  }
  return Container();
}
