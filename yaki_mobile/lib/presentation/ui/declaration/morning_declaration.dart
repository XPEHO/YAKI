import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/presentation/ui/shared/pages_layout_declaration.dart';
import 'package:yaki/presentation/ui/declaration/views/morning_declaration_body.dart';
import 'package:yaki/presentation/ui/shared/views/header_declaration.dart';

class MorningDeclaration extends StatelessWidget {
  const MorningDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagesLayoutDeclaration(
        header: HeaderDeclaration(
          pictoIcon: 'assets/images/avatar1.svg',
          pictoPath: 'assets/images/sun.svg',
          pictoSwitch: 'assets/images/day.svg',
          headerTitle: tr('headerTitleDecla'),
          headerHint: tr('headerHintDeclaMorning'),
        ),
        bodyContent: const MorningDeclarationBody(),
      ),
    );
  }
}
