import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/color.dart';

class InputWithLabelApp extends StatefulWidget {
  final String label;
  final String? initialValue;

  const InputWithLabelApp({super.key, required this.label, this.initialValue});

  @override
  State<InputWithLabelApp> createState() => _InputWithLabelAppState();
}

class _InputWithLabelAppState extends State<InputWithLabelApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // add a label above the input
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.yakiPrimaryColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          initialValue: widget.initialValue,
          // temporarily set to true until we can edit the profile
          readOnly: true,
        ),
      ],
    );
  }
}
