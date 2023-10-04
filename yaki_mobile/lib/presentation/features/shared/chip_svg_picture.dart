import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget declarationChipSvgPicture({required String imageSrc}) {
  return SvgPicture.asset(
    imageSrc,
    width: 32,
    height: 32,
  );
}
