import 'package:flutter/material.dart';

TextStyle textStylePageTitle() {
  return const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );
}

TextStyle textStylePageTitleSummary() {
  return const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
}

TextStyle textStyleSummarySubtitle() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 83, 83, 84),
  );
}

TextStyle textStyleSummary() {
  return const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 83, 83, 84),
  );
}

TextStyle textStylePageDate() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
}

TextStyle textStylePageHint() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}

TextStyle textTeamDeclarationButton() {
  return const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}

TextStyle textTeamsDeclarationListCategory() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(119, 131, 134, 1),
  );
}

TextStyle textFetchError({required double fontSize}) {
  return TextStyle(
    color: Colors.grey,
    fontSize: fontSize,
    fontWeight: FontWeight.w900,
  );
}

// old styles
// ------------------------------------------------------------
TextStyle textStyleHeaderBig() {
  return const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
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

TextStyle registrationSnackTextStyle({required Color textColor}) {
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

TextStyle textStyleDeclaration() {
  return const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );
}
