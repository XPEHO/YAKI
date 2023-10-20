import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavIconCircleAvatar extends StatelessWidget {
  final String imageSrc;
  const NavIconCircleAvatar({
    super.key,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: SvgPicture.asset(
        imageSrc,
        width: 20,
        height: 20,
      ),
    );
  }
}

class CellAvatarSvg extends StatelessWidget {
  final String imageSrc;
  const CellAvatarSvg({
    super.key,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: SvgPicture.asset(
        imageSrc,
        width: 48,
        height: 48,
      ),
    );
  }
}

class CellCircleChipSvg extends StatelessWidget {
  final String imageSrc;
  final Color backgroundColor;
  const CellCircleChipSvg({
    super.key,
    required this.imageSrc,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        child: SvgPicture.asset(
          imageSrc,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}

class CellIconChipSvgPicture extends StatelessWidget {
  final String imageSrc;
  const CellIconChipSvgPicture({
    super.key,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageSrc,
      width: 16,
      height: 16,
    );
  }
}

class UserDeclarationChipSvgPicture extends StatelessWidget {
  final String imageSrc;
  const UserDeclarationChipSvgPicture({
    super.key,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageSrc,
      width: 32,
      height: 32,
    );
  }
}

class AvatarSvg extends StatelessWidget {
  final String imageSrc;
  const AvatarSvg({
    Key? key,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 160,
      child: SvgPicture.asset(
        imageSrc,
      ),
    );
  }
}
