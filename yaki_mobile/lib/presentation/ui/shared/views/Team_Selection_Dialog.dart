import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/team_entity.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/state/providers/halfday_status_provider.dart';

class TeamSelectionDialog {
  /// Shows a dialog with a list of teams to select from.
  ///
  /// The [ref] parameter is a required [WidgetRef] object used for accessing
  /// providers and their values.
  ///
  /// The [morningStatus], [afternoonStatus], and [allDayStatus] parameters are
  /// optional [String] values representing the status to be created by the user.
  ///
  /// The [goToPage] parameter is a required [Function] object representing the
  /// function to be called when the team is selected and the status is created.
  ///
  /// The [context] parameter is a required [BuildContext] object used for
  /// building the dialog.
  static void show({
    required WidgetRef ref,
    required String? morningStatus,
    required String? afternoonStatus,
    required String? allDayStatus,
    required Function goToPage,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("select a team"),
        content: _buildTeamList(
            ref, morningStatus, afternoonStatus, allDayStatus, goToPage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  /// Builds a [ListView] containing a list of teams.
  ///
  /// This method is used to build the content of the dialog. It takes the same
  /// parameters as the [show] method.
  static Widget _buildTeamList(
    WidgetRef ref,
    String? morningStatus,
    String? afternoonStatus,
    String? allDayStatus,
    Function goToPage,
  ) {
    final List<TeamEntity> teamList = ref.watch(teamProvider);
    return Container(
      height: 300.0,
      width: 300.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: teamList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              _handleTeamSelection(ref, teamList[index], morningStatus,
                  afternoonStatus, allDayStatus, goToPage);
            },
            child: ListTile(
              title: Text(teamList[index].teamName ?? "No name available"),
            ),
          );
        },
      ),
    );
  }

  /// Handles the selection of a team and the creation of a status.
  ///
  /// This method is called when the user selects a team from the list. It takes
  /// the same parameters as the [show] method.
  static Future<void> _handleTeamSelection(
    WidgetRef ref,
    TeamEntity selectedTeam,
    String? morningStatus,
    String? afternoonStatus,
    String? allDayStatus,
    Function goToPage,
  ) async {
    if (allDayStatus != null) {
      await ref.read(declarationProvider.notifier).createAllDay(allDayStatus);
      ref.read(statusPageProvider.notifier).getSelectedStatus();
    } else if (morningStatus != null && afternoonStatus != null) {
      await ref
          .read(declarationProvider.notifier)
          .createHalfDay(morningStatus, afternoonStatus);
      ref.read(halfdayStatusPageProvider.notifier).getHalfdayDeclaration();
    } else if (morningStatus != null) {
      ref
          .read(declarationProvider.notifier)
          .setMorningDeclaration(morningStatus);
    }
    goToPage();
  }
}
