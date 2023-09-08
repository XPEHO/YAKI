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
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

TextStyle registrationCancelTextStyle() {
  return const TextStyle(
    color: Color.fromARGB(255, 231, 229, 229),
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

TextStyle registratonSnackTextStyle({required Color textColor}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
}

TextStyle textStyleUserRedirectStyle() {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 46, 46, 45),
  );
}

TextStyle textStyleUserRedirectStyleTeam() {
  return const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 42, 43, 42),
  );
}
