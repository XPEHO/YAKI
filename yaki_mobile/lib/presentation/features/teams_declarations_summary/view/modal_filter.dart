import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/user_entity.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/state/providers/teammate_provider.dart';
import 'package:yaki/presentation/state/providers/user_provider.dart';

class ModalFilter extends ConsumerWidget {
  const ModalFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamProvider);
    final teammates = ref.watch(teammateNotifierProvider) ;
    final UserEntity? user = ref.watch(userProvider);
    debugPrint(user.toString());
    debugPrint(teams.toString());
    debugPrint(teammates.toString());

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
        itemCount: teams.fetchedTeamList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(teams.teamName),
            children: teams.fetchedTeamList.map((teammate) {
              final teammate = teammates.fetchedTeammateList[index];
              return ListTile(
                title:
                    Text('${teammate.userFirstName} ${teammate.userLastName}'),
              );
              
            }).toList(),
          );
        },
      ),
    );
  }
}
