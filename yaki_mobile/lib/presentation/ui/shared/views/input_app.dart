import 'package:flutter/material.dart';

class InputApp extends StatefulWidget {
  final String inputText;
  final String inputHint;
  final bool password;
  final TextEditingController controller;

  /// Generic input component with 3 args : <br>
  /// inputText (String): text in the input
  /// inputHint (String) : text who appear when input is empty
  /// password (boolean) : makes dots instead of text
  const InputApp({
    super.key,
    required this.inputText,
    required this.inputHint,
    required this.password,
    required this.controller,
  });

  @override
  State<InputApp> createState() => _InputAppState();
}

class _InputAppState extends State<InputApp> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.password,
      decoration: InputDecoration(
        hintText: widget.inputText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
