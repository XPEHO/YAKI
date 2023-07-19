import 'package:flutter/material.dart';

class InputRegistration extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validatorFunction;

  const InputRegistration({
    super.key,
    required this.controller,
    required this.label,
    required this.validatorFunction,
  });

  @override
  State<InputRegistration> createState() => _InputRegistrationState();
}

class _InputRegistrationState extends State<InputRegistration> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validatorFunction,
        cursorColor: const Color.fromARGB(64, 91, 90, 90),
        // Decoration
        decoration: InputDecoration(
          errorMaxLines: 4,
          // Label info
          labelText: widget.label,
          labelStyle: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color.fromARGB(153, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }
}
