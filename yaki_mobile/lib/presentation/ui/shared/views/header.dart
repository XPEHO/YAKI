import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/shared/views/avatar_icon.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';

class Header extends StatelessWidget {
  final String? pictoIcon;
  final String pictoPath;
  final String headerTitle;
  final String headerHint;
  final void Function()? onPressed;

  const Header({
    super.key,
    this.pictoIcon,
    required this.pictoPath,
    required this.headerTitle,
    required this.headerHint,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: AppColors.yakiPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: textStyleHeaderBig(),
                  ),
                  const Spacer(),
                  // top right circle avatar
                  if (pictoIcon != null) ...[
                    AvatarIcon(
                      pictoIcon: pictoIcon != ""
                          ? pictoIcon!
                          : "assets/images/dots.svg",
                      onPressed: onPressed ?? () {},
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: CircleAvatarSVG(iconPath: pictoPath, radius: 100),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  headerHint,
                  style: textStyleHeaderBig(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
