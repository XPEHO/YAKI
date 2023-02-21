import 'package:flutter/material.dart';
import 'presentation/ui/shared/views/Header.dart';
import 'package:easy_localization/easy_localization.dart';

class Authentification extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 6,
            child: Header(
              pictoIcon: 'assets/images/dots.svg',
              pictoPath: 'assets/images/authent.svg',
              headerTitle: tr('headerTitle'),
              headerHint: tr('headerHint'),
            )),
        Expanded(flex: 7, child: Container())
      ],
    ));
  }
}
