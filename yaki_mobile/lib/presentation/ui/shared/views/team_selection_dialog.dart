import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/team_entity.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/state/providers/halfday_status_provider.dart';

class TeamSelectionDialog {
  final WidgetRef ref;
  final String? morningStatus;
  final String? afternoonStatus;
  final String? allDayStatus;
  final Function goToPage;
  final BuildContext context;

  const TeamSelectionDialog({
    required this.ref,
    required this.morningStatus,
    required this.afternoonStatus,
    required this.allDayStatus,
    required this.goToPage,
    required this.context,
  });

  /// Shows the dialog with a list of teams to select from.
  Future<void> show() async {
    // Get the team list from the provider
    final teamList = ref.watch(teamProvider);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select a team'),
        content: SizedBox(
          height: 300.0,
          width: 300.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: teamList.length,
            // Use a ListTile for each team in the list
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  // Call _handleTeamSelection when a team is tapped
                  await _handleTeamSelection(teamList[index]);
                },
                child: ListTile(
                  // Show the name of the team in the ListTile
                  title: Text(teamList[index].teamName ?? 'No name available'),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Handles the selection of a team and creates a corresponding status.
  ///
  /// The [selectedTeam] parameter is a required [TeamEntity] representing the
  /// team that was selected by the user.
  ///
  /// If the [allDayStatus] parameter is not null, an all-day status with the
  /// given status message is created using the [declarationProvider] and the
  /// [statusPageProvider] is notified to update the selected status.
  ///
  /// If both the [morningStatus] and [afternoonStatus] parameters are not null,
  /// a half-day status with the given status messages for morning and afternoon
  /// is created using the [declarationProvider] and the
  /// [halfdayStatusPageProvider] is notified to update the half-day declaration.
  ///
  /// If only the [morningStatus] parameter is not null, a morning status with
  /// the given status message is created using the [declarationProvider].
  ///
  /// The [goToPage] function passed in the constructor is called to navigate
  /// to the appropriate page after the status is created.
  Future<void> _handleTeamSelection(TeamEntity selectedTeam) async {
    if (allDayStatus != null) {
      await ref.read(declarationProvider.notifier).createAllDay(allDayStatus!);
      ref.read(statusPageProvider.notifier).getSelectedStatus();
    } else if (morningStatus != null && afternoonStatus != null) {
      await ref
          .read(declarationProvider.notifier)
          .createHalfDay(morningStatus!, afternoonStatus!);
      ref.read(halfdayStatusPageProvider.notifier).getHalfdayDeclaration();
    } else if (morningStatus != null) {
      ref
          .read(declarationProvider.notifier)
          .setMorningDeclaration(morningStatus!);
    }
    goToPage();
  }
}
