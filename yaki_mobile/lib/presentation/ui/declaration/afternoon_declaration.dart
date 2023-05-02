import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/presentation/ui/declaration/views/afternoon_declaration_body.dart';
import 'package:yaki/presentation/ui/shared/pages_layout_declaration.dart';
import 'package:yaki/presentation/ui/shared/views/header_declaration.dart';

class AfternoonDeclaration extends StatelessWidget {
  const AfternoonDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagesLayoutDeclaration(
        header: HeaderDeclaration(
          pictoIcon: 'assets/images/avatar1.svg',
          pictoPath: 'assets/images/moon.svg',
          pictoSwitch: 'assets/images/day.svg',
          headerTitle: tr('headerTitleDecla'),
          headerHint: tr('headerHintDeclaAfternoon'),
        ),
        bodyContent: const AfternoonDeclarationBody(),
      ),
    );
  }
}
