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
                child: Header()),
            const Expanded(
                flex: 7,
                child: Text(' '))
          ],
    ));
  }
}


