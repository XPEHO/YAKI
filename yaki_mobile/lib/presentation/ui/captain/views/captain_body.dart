
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/ui/captain/views/team_mate_card.dart';
import 'package:yaki/presentation/ui/shared/views/InputApp.dart';

import 'package:yaki/presentation/state/providers/team_mate_provider.dart';


class CaptainBody extends ConsumerWidget {

  final captainInputController = TextEditingController();

  CaptainBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listTeamMate = ref.watch(teamMateProvider);

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
          // Cards of the Team Mate
          width: size.width * 0.95,
          height: size.height * 0.14,
          child: Wrap(
            children: listTeamMate.map((e) => Text('coucou')).toList()
          ),
        ),
      ],
    );
  }
}
