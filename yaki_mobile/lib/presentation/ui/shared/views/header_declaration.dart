import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/presentation/ui/declaration/morning_declaration.dart';

import '../../../styles/header_text_style.dart';
import 'avatar_icon.dart';
import 'circle_avatar_svg.dart';

class HeaderDeclaration extends StatelessWidget {
  final String pictoIcon;
  final String pictoPath;
  final String pictoSwitch;
  final String headerTitle;
  final String headerHint;

  const HeaderDeclaration({
    super.key,
    required this.pictoIcon,
    required this.pictoPath,
    required this.pictoSwitch,
    required this.headerTitle,
    required this.headerHint,
  });

  void onAvatarIconPress() {}



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
                  AvatarIcon(
                    pictoIcon: pictoIcon,
                    onPressed: onAvatarIconPress,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      child: CircleAvatarSVG(iconPath: pictoPath, radius: 100),
                    ),
                  ),
                  Positioned(
                    right: 120,
                    top: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Material(
                        elevation: 10,
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: () {
                            if (ModalRoute.of(context)?.settings?.name == '/morning_declaration') {
                              Navigator.pushReplacementNamed(context, '/declaration');
                            } else {
                              Navigator.pushReplacementNamed(context, '/morning_declaration');
                            }
                          },
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: HeaderColor.yellowApp,
                              border: Border.all(
                                color: Colors.deepOrangeAccent,
                                width: 3.0,
                              ),
                              shape: BoxShape.circle,
                            ),
                            width: 60,
                            height: 60,
                            child: Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: SvgPicture.asset(
                                  pictoSwitch,
                                ),
                              ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
              child: Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    headerHint,
                    style: textStyleTemp(),
                  ),
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
