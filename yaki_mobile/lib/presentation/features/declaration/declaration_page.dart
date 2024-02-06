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
    // Teams selected by the user for the declaration
    final List<TeamModel> selectedTeams =
        ref.read(teamProvider).selectedTeamList;

    final List<String> selectedTeamsName = selectedTeams.isNotEmpty
        ? selectedTeams.map((e) => e.teamName).toList()
        : [""];

    LocationCardContent locationCardContent = setLocationCardContent(
      declarationMode: declarationMode,
      teamNameList: selectedTeamsName,
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
                  teamNameList: selectedTeamsName,
                  teamList: selectedTeams,
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
                            teamList: selectedTeams,
                            buttonValue: locationCardContent.subtitle.first,
                          );
                          redirection(
                            context: context,
                            declarationMode: declarationMode,
                            teamNameList: selectedTeamsName,
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
                            teamList: selectedTeams,
                            buttonValue: locationCardContent.subtitle.last,
                          );
                          redirection(
                            context: context,
                            declarationMode: declarationMode,
                            teamNameList: selectedTeamsName,
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
///
/// Depending of the declarationMode, the redirection will be:
/// * **Declaration fullDay** will redirect to the **summary page "fullDay"**
/// * **Declaration timeOfDay** (2 teams was selected) will redirect to **halfDayStart** OR **halfDayEnd** depending of the absence selection.
/// Goes to **halfDayEnd if absence is selected**, as timeOfDay page request to know **WHEN** user is absent,
/// therefore deduce **WHEN** the user is working for the team, only need to know **WHERE** he is working.
/// * **Declaration halfDayStart** will redirect to **halfDayEnd** (2 teams was selected).
/// * **Declaration halfDayEnd** will redirect to the **summary page "halfDay"**
///
/// Given the declarationMode (parameter retrive from router and set for redirection with /declaration/:declarationMode).
/// Determine if the redirection is possible given the set declarationPaths enum (prevent user to go to a page that is not possible to access).
/// if the declarationMode is not found in the enum, the user will be redirected to the authen page.
void redirection({
  required BuildContext context,
  required String declarationMode,
  required List<String> teamNameList,
}) {
  bool isAbsenceSelected = teamNameList.contains("Absence");

  DeclarationPaths redirection = DeclarationPaths.unknown;

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

  // DeclarationPaths.values retrive list of all the enum values (keys
  for (DeclarationPaths path in DeclarationPaths.values) {
    if (path.text == declarationMode) {
      redirection = path;
    }
  }
  context.go(redirectionPath[redirection]!);
}

/// Determine the content of the header depending of the declarationMode.
/// FullDay and TimeOfDay have the same header.  (yet not the same content)
/// HalfDayStart and HalfDayEnd have the same header.
Widget setPageHeader({
  required String declarationMode,
  required List<String> teamNameList,
  required List<TeamModel> teamList,
}) {
  return declarationMode == DeclarationPaths.fullDay.text ||
          declarationMode == DeclarationPaths.timeOfDay.text
      ? HeaderDeclarationSingleChoice(
          declarationMode: declarationMode,
          teamNameList: teamNameList,
          teamList: teamList,
        )
      : declarationMode == DeclarationPaths.halfDayStart.text ||
              declarationMode == DeclarationPaths.halfDayEnd.text
          ? HeaderDeclarationHalfDayChoice(
              declarationMode: declarationMode,
              teamNameList: teamNameList,
              teamList: teamList,
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

  bool isTimeOfDay = declarationMode == DeclarationPaths.timeOfDay.text;

  bool isFullOrHalfDay = declarationMode == DeclarationPaths.fullDay.text ||
      declarationMode == DeclarationPaths.halfDayStart.text ||
      declarationMode == DeclarationPaths.halfDayEnd.text;

  if (isTimeOfDay) {
    imageSrc = [
      'assets/images/Time-Morning.svg',
      'assets/images/Time-Afternoon.svg',
    ];
    // if absence is selected, the title will be "thisMorning" and "thisAfternoon"
    title = teamNameList.contains("Absence")
        ? ["thisMorning", "thisAfternoon"]
        : ['IWorkthisMorning', 'IWorkthisAfternoon'];

    subtitle = [StatusEnum.morning, StatusEnum.afternoon];
  }
  // Check if it's a full or half day
  else if (isFullOrHalfDay) {
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
