import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String pictoIcon;
  final String pictoPath;
  final String headerTitle;
  final String headerHint;

  //Header({Key? key}) : super(key: key);
  Header(
      {super.key,
      required this.pictoIcon,
      required this.pictoPath,
      required this.headerTitle,
      required this.headerHint});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          color: Colors.amber[400],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 4),
          ]),
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
                    CircleAvatarSVG(iconPath: pictoIcon, radius: 20),
                  ],
                )),
            Expanded(
                flex: 3,
                child: CircleAvatarSVG(iconPath: pictoPath, radius: 100)),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    headerHint,
                    style: textStyleTemp(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

TextStyle textStyleTemp() {
  return const TextStyle(
      fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white);
}

class CircleAvatarSVG extends StatelessWidget {
  final String iconPath;
  final double radius;

  const CircleAvatarSVG(
      {super.key, required this.iconPath, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      //backgroundImage:  AssetImage("assets/images/authent.png"),
      radius: radius,
      child: Container(child: SvgPicture.asset(iconPath)),
    );
  }
}

class CircleAvatarPNG extends StatelessWidget {
  final String iconPath;
  final double radius;

  const CircleAvatarPNG(
      {super.key, required this.iconPath, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage(iconPath),
      radius: radius,
    );
  }
}
