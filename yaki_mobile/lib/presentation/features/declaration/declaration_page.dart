import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/domain/entities/location_card_content.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_summary_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/declaration/view/header_declaration_half_day_choice.dart';
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

    final List<String> teamNameList =
        teamList.isNotEmpty ? teamList.map((e) => e.teamName).toList() : [""];

    LocationCardContent locationCardContent = setLocationCardContent(
      declarationMode: declarationMode,
      teamNameList: teamNameList,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go("/team-selection");
            ref.read(teamProvider.notifier).clearTeamList();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                setPageHeader(
                  declarationMode: declarationMode,
                  teamNameList: teamNameList,
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: LocationSelectionCard(
                        picture: SvgPicture.asset(
                          locationCardContent.imageSrc.first,
                          width: 112,
                          height: 112,
                        ),
                        title: tr(
                          locationCardContent.title.first,
                        ),
                        subtitle: tr(
                          locationCardContent.subtitle.first.name,
                        ),
                        onSelectionChanged: (selected) {
                          onPress(
                            ref: ref,
                            declarationMode:
                                DeclarationPaths.fromText(declarationMode),
                            teamList: teamList,
                            buttonValue: locationCardContent.subtitle.first,
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
                          locationCardContent.imageSrc.last,
                          width: 112,
                          height: 112,
                        ),
                        title: tr(
                          locationCardContent.title.last,
                        ),
                        subtitle: tr(
                          locationCardContent.subtitle.last.name,
                        ),
                        onSelectionChanged: (selected) {
                          onPress(
                            ref: ref,
                            declarationMode:
                                DeclarationPaths.fromText(declarationMode),
                            teamList: teamList,
                            buttonValue: locationCardContent.subtitle.last,
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
              ],
            ),
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

/// Determine the redirection depending of the declarationMode.
/// Only the declarationMode "time-of-day" have different redirection because of the possible halfDay with an absence.
void redirection({
  required BuildContext context,
  required String declarationMode,
  required List<String> teamNameList,
}) {
  bool isAbsenceSelected = teamNameList.contains("Absence");

  // map with redirection depending of the DeclarationPaths
  final redirectionPath = {
    DeclarationPaths.fullDay:
        "/summary/${DeclarationSummaryPaths.fullDay.text}",
    DeclarationPaths.timeOfDay: isAbsenceSelected
        ? "/declaration/${DeclarationPaths.halfDayEnd.text}"
        : "/declaration/${DeclarationPaths.halfDayStart.text}",
    DeclarationPaths.halfDayStart:
        "/declaration/${DeclarationPaths.halfDayEnd.text}",
    DeclarationPaths.halfDayEnd:
        "/summary/${DeclarationSummaryPaths.halfDay.text}",
  };

  DeclarationPaths redirection = DeclarationPaths.unknown;
  // retrive the DeclarationPaths.'key' according to the declarationMode
  for (DeclarationPaths path in DeclarationPaths.values) {
    if (path.text == declarationMode) {
      redirection = path;
    }
  }
  context.go(redirectionPath[redirection]!);
}

Widget setPageHeader({
  required String declarationMode,
  required List<String> teamNameList,
}) {
  return declarationMode == DeclarationPaths.fullDay.text ||
          declarationMode == DeclarationPaths.timeOfDay.text
      ? HeaderDeclarationSingleChoice(
          declarationMode: declarationMode,
          teamNameList: teamNameList,
          imageSrc: '',
        )
      : declarationMode == DeclarationPaths.halfDayStart.text ||
              declarationMode == DeclarationPaths.halfDayEnd.text
          ? HeaderDeclarationHalfDayChoice(
              declarationMode: declarationMode,
              teamNameList: teamNameList,
              imageSrc: '',
            )
          : Container();
}

/// Determine the content of both LocationSelectionCard depending of the declarationMode.
/// And the teamNameList to determine if the absence is selected.
LocationCardContent setLocationCardContent({
  required String declarationMode,
  required List<String> teamNameList,
}) {
  List<String> imageSrc = [];
  List<String> title = [];
  List<StatusEnum> subtitle = [];

  // time of day with absence check
  if (declarationMode == DeclarationPaths.timeOfDay.text) {
    imageSrc = [
      'assets/images/Time-Morning.svg',
      'assets/images/Time-Afternoon.svg',
    ];
    title = teamNameList.contains("Absence")
        ? ["thisMorning", "thisAfternoon"]
        : ['IWorkthisMorning', 'IWorkthisAfternoon'];
    subtitle = [StatusEnum.morning, StatusEnum.afternoon];
  }
  // the others declaration paths
  if (declarationMode == DeclarationPaths.fullDay.text ||
      declarationMode == DeclarationPaths.halfDayStart.text ||
      declarationMode == DeclarationPaths.halfDayEnd.text) {
    imageSrc = ['assets/images/Work-Office.svg', 'assets/images/Work-Home.svg'];
    title = ['Iam', 'Iam'];
    subtitle = [StatusEnum.onSite, StatusEnum.remote];
  }

  return LocationCardContent(
    title: title,
    subtitle: subtitle,
    imageSrc: imageSrc,
  );
}
