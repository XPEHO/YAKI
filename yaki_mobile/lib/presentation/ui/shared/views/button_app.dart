import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/color.dart';

class ButtonApp extends StatefulWidget {
  final String textButton;
  final Function onPressed;

  /// Generic button component with 1 arg : <br>
  /// textButton : Text who appear on the button
  const ButtonApp({
    super.key,
    required this.textButton,
    required this.onPressed,
  });

  @override
  State<ButtonApp> createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: AppColors.yakiPrimaryColor,
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: size.height / 25,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 50,
          left: 50,
        ),
      ),
      onPressed: () {
        widget.onPressed;
      },
      child: Text(widget.textButton),
    );
  }
}
