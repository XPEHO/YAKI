import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/features/declaration/view/header_declaration_single_choice.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class DeclarationPage extends ConsumerWidget {
  final String declarationMode;

  const DeclarationPage({
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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                HeaderDeclarationSingleChoice(
                  declarationMode: declarationMode,
                  teamNameList: teamNameList,
                  imageSrc: '',
                ),
                const SizedBox(height: 48),
                SizedBox(
                  height: 240,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: LocationSelectionCard(
                          picture: SvgPicture.asset(
                            setImage(declarationMode).first,
                            width: 112,
                            height: 112,
                          ),
                          title: tr(
                            setCardTitle(
                              declarationMode: declarationMode,
                              teamNameList: teamNameList,
                            ).first,
                          ),
                          subtitle:
                              tr(setCardSubtitle(declarationMode).first.name),
                          onSelectionChanged: (selected) {
                            onPress(
                              ref: ref,
                              declarationMode:
                                  DeclarationPaths.fromText(declarationMode),
                              teamList: teamList,
                              buttonValue:
                                  setCardSubtitle(declarationMode).first,
                            );
                            redirection(
                              context: context,
                              declarationMode: declarationMode,
                              teamNameList: teamNameList,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        flex: 1,
                        child: LocationSelectionCard(
                          picture: SvgPicture.asset(
                            setImage(declarationMode).last,
                            width: 112,
                            height: 112,
                          ),
                          title: tr(
                            setCardTitle(
                              declarationMode: declarationMode,
                              teamNameList: teamNameList,
                            ).last,
                          ),
                          subtitle:
                              tr(setCardSubtitle(declarationMode).last.name),
                          onSelectionChanged: (selected) {
                            onPress(
                              ref: ref,
                              declarationMode:
                                  DeclarationPaths.fromText(declarationMode),
                              teamList: teamList,
                              buttonValue:
                                  setCardSubtitle(declarationMode).last,
                            );
                            redirection(
                              context: context,
                              declarationMode: declarationMode,
                              teamNameList: teamNameList,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 25, left: 25, right: 0, bottom: 32),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go("/team-selection");
              ref.read(teamProvider.notifier).clearTeamList();
            },
          ),
        ),
      ),
    );
  }
}

void onPress({
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
  required List<String> teamNameList,
}) {
  bool isAbsenceSelected = teamNameList.contains("Absence");

  if (declarationMode == DeclarationPaths.fullDay.text) {
    context.go("/status");
  }
  if (declarationMode == DeclarationPaths.timeOfDay.text) {
    if (isAbsenceSelected) {
      context.go("/declaration/half-day-end");
    } else {
      context.go("/declaration/half-day-start");
    }
  }
}

List<String> setCardTitle({
  required String declarationMode,
  required List<String> teamNameList,
}) {
  List<String> cardText = [];
  if (declarationMode == DeclarationPaths.timeOfDay.text) {
    cardText = teamNameList.contains("Absence")
        ? ["thisMorning", "thisAfternoon"]
        : ['IWorkthisMorning', 'IWorkthisAfternoon'];
  } else if (declarationMode == DeclarationPaths.fullDay.text) {
    cardText = ['Iam', 'Iam'];
  }
  return cardText;
}

List<String> setImage(String declarationMode) {
  List<String> imageSrc = [];
  if (declarationMode == DeclarationPaths.timeOfDay.text) {
    imageSrc = [
      'assets/images/Time-Morning.svg',
      'assets/images/Time-Afternoon.svg',
    ];
  } else if (declarationMode == DeclarationPaths.fullDay.text) {
    imageSrc = ['assets/images/Work-Office.svg', 'assets/images/Work-Home.svg'];
  }
  return imageSrc;
}

/// Determine the buttons's text depending of the declarationMode.
/// Only the declarationMode "time-of-day" have different buttons text.
/// For the halfDay we start by selecting the moment of the day (morning or afternoon)
List<StatusEnum> setCardSubtitle(String declarationMode) {
  List<StatusEnum> buttonsText = [];
  if (declarationMode == DeclarationPaths.timeOfDay.text) {
    buttonsText = [StatusEnum.morning, StatusEnum.afternoon];
  } else if (declarationMode == DeclarationPaths.fullDay.text) {
    buttonsText = [StatusEnum.remote, StatusEnum.onSite];
  }
  return buttonsText;
}
