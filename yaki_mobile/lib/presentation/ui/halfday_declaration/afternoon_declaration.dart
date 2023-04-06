import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/presentation/ui/halfday_declaration/views/afternoon_declaration_body.dart';
import 'package:yaki/presentation/ui/shared/pages_layout.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

class AfternoonDeclaration extends StatelessWidget {
  const AfternoonDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagesLayout(
        header: Header(
          pictoIcon: 'assets/images/avatar1.svg',
          pictoPath: 'assets/images/unknown.svg',
          headerTitle: tr('headerTitleDecla'),
          headerHint: tr('headerHintDecla'),
        ),
        bodyContent: const AfternoonDeclarationBody(),
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
