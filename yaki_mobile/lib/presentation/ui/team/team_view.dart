import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/ui/captain/views/team_body.dart';

import '../shared/pages_layout.dart';
import '../shared/views/header.dart';


class TeamView extends StatefulWidget {
  const TeamView({super.key});

  @override
  State<StatefulWidget> createState() => _TeamView();
}

class _TeamView extends State<TeamView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagesLayout(
        header: Header(
          pictoIcon: 'assets/images/captain.svg',
          pictoPath: 'assets/images/captain.svg',
          headerTitle: tr('captainTitle'),
          headerHint: tr('captainHeaderTitle'),
        ),
        bodyContent: const TeamBody(),
      ),
    );
  }
}