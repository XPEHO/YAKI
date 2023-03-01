import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../shared/pages_layout.dart';
import '../shared/views/header.dart';
import 'views/declaration_body.dart';

class Declaration extends StatelessWidget {
  const Declaration({super.key});

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
        bodyContent: const DeclarationBody(),
      ),
    );
  }
}
