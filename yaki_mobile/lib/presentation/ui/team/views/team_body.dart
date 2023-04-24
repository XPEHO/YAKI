import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/ui/team/views/team_card.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/ui/shared/views/input_app.dart';

class TeamBody extends ConsumerStatefulWidget {
  const TeamBody({super.key});

  @override
  ConsumerState<TeamBody> createState() => _TeamBodyState();
}

class _TeamBodyState extends ConsumerState<TeamBody> {
  final captainInputController = TextEditingController();

  /// Retrieves data from the team_notifier.dart
  @override
  void initState() {
    setState(() {
      ref.read(teamProvider.notifier).fetchTeams();
    });
    super.initState();
  }

  void onStatusTeamPress(BuildContext context) {
    context.go('/status');
  }

  @override
  Widget build(BuildContext context) {
    // Monitors changes in card status
    final listTeam = ref.watch(teamProvider);

    // recovers device dimensions
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: InputApp(
            // Field for search by name or status
            inputText: tr('inputCaptain'),
            inputHint: tr('hintCaptain'),
            password: false,
            controller: captainInputController,
          ),
        ),
        SizedBox(
          width: size.width * 0.95,
          height: size.height * 0.4,
          child: ListView.builder(
            // This widget allows you to create a list object and iterate on it
            itemCount: listTeam.length,
            itemBuilder: (context, index) {
              //child: InkWell(
                  //onTap: () => onStatusTeamPress(context),
              return CardTeam(

                // Cards of the Team Mate
                teamId: (listTeam[index].teamId),
                teamName: listTeam[index].teamName ?? "No name available",

              );
              //);
            },
          ),
        ),
      ],
    );
  }
}
