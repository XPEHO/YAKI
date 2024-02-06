import 'dart:typed_data';

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
  const CellAvatarSvg({super.key, required this.imageSrc});

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

class CellAvatarImg extends StatelessWidget {
  final Uint8List imageAvatar;
  const CellAvatarImg({super.key, required this.imageAvatar});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          48.0,
        ), // adjust the radius as needed
        child: Image.memory(imageAvatar),
      ),
    );
  }
}

class CellAvatarLetters extends StatelessWidget {
  final String userFirstLetters;
  const CellAvatarLetters({super.key, required this.userFirstLetters});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.0,
      height: 48.0,
      decoration: const BoxDecoration(
        color: Color(0xFFFFD7C0),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          userFirstLetters,
          style: const TextStyle(
            color: Color(0xFF7D818C),
            fontSize: 18,
          ),
        ),
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

class ProfilAvatarSvg extends StatelessWidget {
  final String imageSrc;
  const ProfilAvatarSvg({
    super.key,
    required this.imageSrc,
  });

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
