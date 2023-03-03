import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/presentation/ui/declaration/views/declaration_body.dart';
import 'package:yaki/presentation/ui/shared/pages_layout.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

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
