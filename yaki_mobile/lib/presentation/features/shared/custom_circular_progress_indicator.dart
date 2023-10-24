import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/color.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 70,
      height: 70,
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: 6,
        semanticsLabel: 'Loading',
      ),
    );
  }
}
