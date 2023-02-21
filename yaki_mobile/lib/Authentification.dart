import 'package:flutter/material.dart';
import 'presentation/ui/shared/views/Header.dart';

class Authentification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return the size of the device
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 6,
            child: Header(
              pictoIcon: 'assets/images/dots.svg',
              pictoPath: 'assets/images/authent.svg',
              headerTitle: 'Authentification',
              headerHint: 'Who are you ?',
            )),
        const Expanded(flex: 7, child: Text(' '))
      ],
    ));
  }
}
