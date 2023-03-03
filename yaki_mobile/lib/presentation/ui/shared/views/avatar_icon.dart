import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';
import 'package:flutter/material.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon(
      {super.key, required this.pictoIcon, required this.onPressed});

  final String pictoIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      child: CircleAvatarSVG(
        iconPath: pictoIcon,
        radius: 20,
      ),
    );
  }
}
