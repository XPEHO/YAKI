import 'package:flutter/material.dart';

class HeaderColor {
  static const Color yellowApp = Color.fromARGB(255, 245, 205, 61);
}

TextStyle textStyleHeaderBig() {
  return const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

TextStyle textStyleHeaderSmall() {
  return const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
