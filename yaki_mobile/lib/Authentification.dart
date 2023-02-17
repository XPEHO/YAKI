import 'package:flutter/material.dart';

class Authentification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // return the size of the device
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: upsideBloc(size),
    );
  }
  
}

Container upsideBloc(Size size) {
  return Container(
    color: Colors.orange,
    height: size.height,
    width: size.width,
  );
}