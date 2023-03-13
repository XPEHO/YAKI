import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CircleAvatarSVG extends StatelessWidget {
  final String iconPath;
  final double radius;

  const CircleAvatarSVG({
    super.key,
    required this.iconPath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      child: SvgPicture.asset(iconPath),
    );
  }
}
