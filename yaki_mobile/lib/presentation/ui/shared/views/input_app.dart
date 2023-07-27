import 'package:flutter/material.dart';

class InputApp extends StatefulWidget {
  final String inputText;
  final String inputHint;
  final bool password;
  final TextEditingController controller;
  final String defaultValue;

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
    required this.defaultValue,
  });

  @override
  State<InputApp> createState() => _InputAppState();
}

class _InputAppState extends State<InputApp> {
  TextEditingController controller = TextEditingController();

  // state used to choose the password display mode (hidden or visible)
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.inputHint,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _passwordVisible,
        decoration: InputDecoration(
          hintText: widget.inputText,
          border: const OutlineInputBorder(),
          suffixIconColor: Colors.grey,
          suffixIcon: widget.password
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _passwordVisible = !_passwordVisible;
                      },
                    );
                  },
                )
              : null,
        ),
      ),
    );
  }
}
