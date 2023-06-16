import 'package:flutter/material.dart';
import 'package:yaki/presentation/ui/captain/views/captain_body.dart';
import 'package:yaki/presentation/ui/shared/pages_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

class CaptainView extends StatefulWidget {
  const CaptainView({super.key});

  @override
  State<StatefulWidget> createState() => _CaptainView();
}

class _CaptainView extends State<CaptainView> {
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
        bodyContent: const CaptainBody(),
      ),
    );
  }
}
