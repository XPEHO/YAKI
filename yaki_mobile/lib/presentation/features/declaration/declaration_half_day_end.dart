import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/features/declaration/view/header_declaration_half_day_choice.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class DeclarationHalfDayEnd extends ConsumerWidget {
  final String declarationMode;

  const DeclarationHalfDayEnd({
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go("/declaration/half-day-start");
            ref.read(teamProvider.notifier).clearTeamList();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                HeaderDeclarationHalfDayChoice(
                  declarationMode: declarationMode,
                  teamList: teamNameList,
                  imageSrc: '',
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: LocationSelectionCard(
                        picture: SvgPicture.asset(
                          'assets/images/Work-Office.svg',
                          width: 112,
                          height: 112,
                        ),
                        title: tr("Iam"),
                        subtitle: tr(StatusEnum.onSite.name),
                        onSelectionChanged: (selected) {
                          onPress(
                            ref: ref,
                            declarationMode:
                                DeclarationPaths.fromText(declarationMode),
                            teamList: teamList,
                            buttonValue: StatusEnum.remote,
                          );
                          redirection(
                            context: context,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      flex: 1,
                      child: LocationSelectionCard(
                        picture: SvgPicture.asset(
                          'assets/images/Work-Home.svg',
                          width: 112,
                          height: 112,
                        ),
                        title: tr("Iam"),
                        subtitle: tr(StatusEnum.remote.name),
                        onSelectionChanged: (selected) {
                          onPress(
                            ref: ref,
                            declarationMode:
                                DeclarationPaths.fromText(declarationMode),
                            teamList: teamList,
                            buttonValue: StatusEnum.onSite,
                          );
                          redirection(
                            context: context,
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

void redirection({
  required BuildContext context,
}) {
  context.go("/status");
}
