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

    var size = MediaQuery.of(context).size;

    return ElevatedButton(
      style:ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: HeaderColor.yellowApp,
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: size.height/25,
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