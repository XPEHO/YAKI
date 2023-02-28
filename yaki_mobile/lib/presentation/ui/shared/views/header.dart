import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/HeaderTextStyle.dart';

class Header extends StatelessWidget {
  final String pictoIcon;
  final String pictoPath;
  final String headerTitle;
  final String headerHint;

  const Header({
    super.key,
    required this.pictoIcon,
    required this.pictoPath,
    required this.headerTitle,
    required this.headerHint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: HeaderColor.yellowApp,
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
                    style: textStyleTemp(),
                  ),

                  const Spacer(),
                  // top right circle avatar
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    child: CircleAvatarSVG(iconPath: pictoIcon, radius: 20),
                  )
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
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  headerHint,
                  style: textStyleTemp(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
