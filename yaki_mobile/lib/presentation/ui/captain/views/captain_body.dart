import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/providers/team_mate_provider.dart';
import 'package:yaki/presentation/ui/captain/views/team_mate_card.dart';
import 'package:yaki/presentation/ui/shared/views/input_app.dart';

class CaptainBody extends ConsumerStatefulWidget {
  const CaptainBody({super.key});

  @override
  ConsumerState<CaptainBody> createState() => _CaptainBodyState();
}

class _CaptainBodyState extends ConsumerState<CaptainBody> {
  final captainInputController = TextEditingController();

  @override
  void initState() {
    setState(() {
      ref.read(teamMateProvider.notifier).fetchTeamMates();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Monitors changes in card status
    final listTeamMate = ref.watch(teamMateProvider);

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
            itemCount: listTeamMate.length,
            itemBuilder: (context, index) {
              return CardTeamMate(
                // Cards of the Team Mate
                firstName: (listTeamMate[index].userFirstname),
                lastName: (listTeamMate[index].userLastName),
                dateActu: (listTeamMate[index].declarationDate),
                status: (listTeamMate[index].declarationStatus),
              );
            },
          ),
        ),
      ],
    );
  }
}
