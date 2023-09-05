import 'package:flutter/material.dart';

SnackBar registrationSnack({
  required String content,
  required TextStyle textStyle,
  required Function barAction,
  required String actionLabel,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 999),
    margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
    backgroundColor: const Color.fromARGB(255, 75, 75, 75),
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          content,
          style: textStyle,
        ),
      ),
    ),
    action: SnackBarAction(
      label: actionLabel,
      disabledTextColor: Colors.white,
      textColor: const Color.fromARGB(255, 226, 223, 223),
      onPressed: () => barAction(),
    ),
  );
}
