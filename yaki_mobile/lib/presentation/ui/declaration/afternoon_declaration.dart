import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/ui/declaration/views/declaration_body.dart';

import '../shared/pages_layout_declaration.dart';
import '../shared/views/header_declaration.dart';

class AfternoonDeclaration extends StatelessWidget {
  const AfternoonDeclaration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagesLayoutDeclaration(
        header: HeaderDeclaration(
          pictoIcon: 'assets/images/avatar1.svg',
          pictoPath: 'assets/images/moon.svg',
          pictoSwitch: 'assets/images/pm.svg',
          headerTitle: tr('headerTitleDecla'),
          headerHint: tr('headerHintDeclaAfternoon'),
        ),
        bodyContent: const DeclarationBody(),
      ),
    );
  }
}
