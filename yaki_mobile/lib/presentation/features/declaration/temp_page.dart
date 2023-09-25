import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
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
                text: tr(setButtonsText(declarationMode).first.name),
                onPressed: () {
                  onButtonPress(
                    ref: ref,
                    declarationMode: DeclarationPaths.fromText(declarationMode),
                    teamList: teamList,
                    buttonValue: setButtonsText(declarationMode).first,
                  );
                  redirection(
                    context: context,
                    declarationMode: declarationMode,
                    teamNamesList: teamNameList,
                  );
                },
                color: const Color.fromARGB(255, 119, 160, 191),
              ),
              const SizedBox(height: 10),
              Button(
                text: tr(setButtonsText(declarationMode).last.name),
                onPressed: () {
                  onButtonPress(
                    ref: ref,
                    declarationMode: DeclarationPaths.fromText(declarationMode),
                    teamList: teamList,
                    buttonValue: setButtonsText(declarationMode).last,
                  );
                  redirection(
                    context: context,
                    declarationMode: declarationMode,
                    teamNamesList: teamNameList,
                  );
                },
                color: const Color.fromARGB(255, 119, 160, 191),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// convert back the declaration mode to a enum value
// to be used in the declarationCreationHandler
void onButtonPress({
  required WidgetRef ref,
  required DeclarationPaths declarationMode,
  required List<TeamModel> teamList,
  required StatusEnum buttonValue,
}) {
  ref.read(declarationProvider.notifier).declarationCreationHandler(
        declarationMode: declarationMode,
        teamList: teamList,
        selectedStatus: buttonValue,
      );
}

void redirection({
  required BuildContext context,
  required String declarationMode,
  required List<String> teamNamesList,
}) {
  bool isAbsenceSelected = teamNamesList.contains("Absence");

  if (declarationMode == DeclarationPaths.fullDay.text) {
    context.go("/status");
  }
  if (declarationMode == DeclarationPaths.timeOfDay.text) {
    if (isAbsenceSelected) {
      context.go("/declaration/${DeclarationPaths.halfDayEnd.text}");
    } else {
      context.go("/declaration/${DeclarationPaths.halfDayStart.text}");
    }
  }
  if (declarationMode == DeclarationPaths.halfDayStart.text) {
    context.go("/declaration/${DeclarationPaths.halfDayEnd.text}");
  }
}

/// Determine the buttons's text depending of the declarationMode.
/// Only the declarationMode "time-of-day" have different buttons text.
/// For the halfDay we start by selecting the moment of the day (morning or afternoon)
List<StatusEnum> setButtonsText(String declarationMode) {
  List<StatusEnum> buttonsText = [];

  if (declarationMode == DeclarationPaths.timeOfDay.text) {
    buttonsText = [StatusEnum.morning, StatusEnum.afternoon];
  } else if (declarationMode == DeclarationPaths.fullDay.text ||
      declarationMode == DeclarationPaths.halfDayStart.text ||
      declarationMode == DeclarationPaths.halfDayEnd.text) {
    buttonsText = [StatusEnum.remote, StatusEnum.onSite];
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
