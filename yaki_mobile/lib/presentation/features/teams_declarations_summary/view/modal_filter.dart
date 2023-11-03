import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/providers/filter_provider.dart';
import 'package:yaki/presentation/state/providers/team_future_provider.dart';
import 'package:yaki/presentation/styles/color.dart';

class ModalFilter extends ConsumerWidget {
  const ModalFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamFutureProvider);
    final filter = ref.watch(filterProvider);
    return teams.when(
      data: (teams) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(tr('filter')),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: teams.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(teams[index].teamName),
              leading: Checkbox(
                value: filter.selectedTeams
                    .contains(teams.elementAt(index).teamId),
                onChanged: (value) {
                  if (value == true) {
                    ref.read(filterProvider.notifier).addTeam(
                          teams.elementAt(index).teamId,
                        );
                  } else {
                    ref.read(filterProvider.notifier).removeTeam(
                          teams.elementAt(index).teamId,
                        );
                  }
                },
                activeColor: AppColors.primaryColor,
              ),
            );
          },
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}
