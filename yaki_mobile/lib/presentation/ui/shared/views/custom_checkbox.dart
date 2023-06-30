import 'package:flutter/material.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/presentation/styles/header_text_style.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool isChecked;

  @override
  void initState() async {
    super.initState();
    isChecked = await SharedPref.getRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      activeColor: HeaderColor.yellowApp,
      onChanged: (bool? value) {
        setState(() async {
          isChecked = value ?? false;
          await SharedPref.setRememberMe(value ?? false);
        });
      },
    );
  }
}
