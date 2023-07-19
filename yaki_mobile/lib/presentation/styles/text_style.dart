import 'package:flutter/material.dart';

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

TextStyle registrationPageTitleTextStyle() {
  return const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 0, 0, 0),
  );
}

TextStyle registrationBtnTextStyle() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );
}

TextStyle registratonSnackTextStyle({required Color textColor}) {
  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
}
