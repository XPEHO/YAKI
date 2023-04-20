import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/providers/team_provider.dart';
import '../shared/views/input_app.dart';

class TeamBody extends ConsumerStatefulWidget {
  const TeamBody({super.key});

  @override
  ConsumerState<TeamBody> createState() => _TeamBodyState();
}

class _TeamBodyState extends ConsumerState<TeamBody> {
  final captainInputController = TextEditingController();

  /// Retrieves data from the team_mate_notifier.dart
  @override
  void initState() {
    setState(() {
      ref.read(teamProvider.notifier).fetchTeams();
    });
    super.initState();
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
              return CardTeam(
                // Cards of the Team Mate
                firstName: (listTeam[index].teamId),
                lastName: (listTeam[index].teamName),

              );
            },
          ),
        ),
      ],
    );
  }
}
