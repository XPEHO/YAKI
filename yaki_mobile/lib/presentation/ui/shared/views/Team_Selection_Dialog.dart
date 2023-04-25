import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/team_entity.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/state/providers/halfday_status_provider.dart';

class StatusSelectionHandler {
  onStatusSelected({
    required WidgetRef ref,
    required String status,
    required Function goToNextPage,
    required BuildContext context,
    String? morningStatus,
    String? afternoonStatus,
    Function()? goToAfternoonDeclaration,
    Function()? goToStatusPage,
  }) {
    final List<TeamEntity> listTeam = ref.watch(teamProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select a team"),
        content: Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listTeam.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {

                  if (morningStatus != null && afternoonStatus != null) {
                    await ref
                        .read(declarationProvider.notifier)
                        .createHalfDay(morningStatus, afternoonStatus);
                    ref.read(halfdayStatusPageProvider.notifier).getHalfdayDeclaration();
                    goToStatusPage?.call();
                  } else if (morningStatus != null) {
                    await ref
                        .read(declarationProvider.notifier)
                        .createAllDay(status);
                    ref.read(statusPageProvider.notifier).getSelectedStatus();
                    goToNextPage();
                  } else if (afternoonStatus != null) {
                    ref.read(declarationProvider.notifier).setMorningDeclaration(status);
                    goToAfternoonDeclaration?.call();
                  }
                },
                child: ListTile(
                  title: Text(listTeam[index].teamName ?? "No name available"),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}