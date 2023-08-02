import 'package:flutter/material.dart';

SnackBar registrationSnack({
  required String content,
  required TextStyle textStyle,
  required Function barAction,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 10),
    backgroundColor: const Color.fromARGB(255, 220, 219, 219),
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          content,
          style: textStyle,
        ),
      ),
    ),
    action: SnackBarAction(
      label: 'Retour',
      disabledTextColor: Colors.white,
      textColor: const Color.fromARGB(255, 0, 0, 0),
      onPressed: () => barAction(),
    ),
  );
}
