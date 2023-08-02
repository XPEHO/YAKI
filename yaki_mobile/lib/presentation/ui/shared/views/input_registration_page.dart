import 'package:flutter/material.dart';

class InputRegistration extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isShown;
  final String? Function(String?) validatorFunction;
  final String Function(String) textCapitalization;

  const InputRegistration({
    super.key,
    required this.controller,
    required this.isShown,
    required this.label,
    required this.validatorFunction,
    required this.textCapitalization,
  });

  @override
  State<InputRegistration> createState() => _InputRegistrationState();
}

class _InputRegistrationState extends State<InputRegistration> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.isShown;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        onChanged: (value) {
          widget.controller.value = TextEditingValue(
            text: widget.textCapitalization(value),
            selection: widget.controller.selection,
          );
        },
        obscureText: _passwordVisible,
        controller: widget.controller,
        validator: widget.validatorFunction,
        cursorColor: const Color.fromARGB(64, 91, 90, 90),
        // Decoration
        decoration: InputDecoration(
          errorMaxLines: 4,
          // Label info
          labelText: widget.label,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 90, 90, 90),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color.fromARGB(153, 0, 0, 0),
            ),
          ),
          suffixIconColor: Colors.grey,
          suffixIcon: widget.isShown
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
