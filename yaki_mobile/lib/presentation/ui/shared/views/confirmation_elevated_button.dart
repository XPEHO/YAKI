import 'package:flutter/material.dart';

class ConfirmationElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final TextStyle btnTextStyle;

  const ConfirmationElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.btnTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        elevation: 5,
        minimumSize: Size(200, 45),
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: btnTextStyle,
      ),
    );
  }
}
