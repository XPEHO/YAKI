import 'package:flutter/material.dart';
import '../../../styles/HeaderTextStyle.dart';

class ButtonApp extends StatefulWidget {

  final String textButton;

  const ButtonApp(
      {
        super.key,
        required this.textButton,
      }
      );

  @override
  State<ButtonApp> createState() => _ButtonAppState();

}

class _ButtonAppState extends State<ButtonApp> {


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:ElevatedButton.styleFrom(
        backgroundColor: HeaderColor.yellowApp,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 50,
          left: 50,
        ),
      ),
      onPressed: () {},
      child: Text(widget.textButton),
    );
  }

}