import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';

class ModalFilter extends ConsumerWidget {
  const ModalFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamProvider);

    return Scaffold(
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
          teamCount: cart.teams.lenght,
          teamBuilder: (context, index){
            return ListTile(
              teamName: Text.teamName(cart.teams[index].name),
          };
  }
}
