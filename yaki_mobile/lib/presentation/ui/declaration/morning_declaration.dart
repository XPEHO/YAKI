import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/ui/declaration/views/declaration_body.dart';

import '../shared/pages_layout_declaration.dart';
import '../shared/views/header_declaration.dart';

class MorningDeclaration extends StatelessWidget {
  const MorningDeclaration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagesLayoutDeclaration(
        header: HeaderDeclaration(
          pictoIcon: 'assets/images/avatar1.svg',
          pictoPath: 'assets/images/sun.svg',
          pictoSwitch: 'assets/images/pm.svg',
          headerTitle: tr('headerTitleDecla'),
          headerHint: tr('headerHintDeclaMorning'),
        ),
        bodyContent: const DeclarationBody(),
      ),
    );
  }
}
