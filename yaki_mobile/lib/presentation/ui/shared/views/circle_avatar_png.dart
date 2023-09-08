import 'package:flutter/material.dart';

class CircleAvatarPNG extends StatelessWidget {
  final String iconPath;
  final double radius;

  const CircleAvatarPNG({
    super.key,
    required this.iconPath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage(iconPath),
      radius: radius,
    );
  }
}
