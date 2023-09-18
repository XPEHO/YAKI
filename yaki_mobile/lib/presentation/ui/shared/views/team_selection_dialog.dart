import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';

class TeamSelectionDialog {
  final WidgetRef ref;
  final BuildContext context;
  final DeclarationTimeOfDay timeOfDay;
  final String? status;
  final Function goToPage;

  const TeamSelectionDialog({
    required this.ref,
    required this.context,
    required this.timeOfDay,
    required this.status,
    required this.goToPage,
  });

  /// Shows the dialog with a list of teams to select from.
  Future<void> show() async {
    // Get the team list from the provider
    final teamList = ref.read(teamProvider).selectedTeamList;
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
                  ref.watch(declarationProvider.notifier).createDeclaration(
                        timeOfDay: timeOfDay,
                        status: status!,
                        teamId: teamList[index].teamId!,
                      );
                  goToPage();
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
}
