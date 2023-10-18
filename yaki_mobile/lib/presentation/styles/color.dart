import 'package:flutter/material.dart';

class AppColors {
  // Primary Color of the app

  static const Color primaryColor = Color(0xFFFF936B);
  static const Color secondaryColor = Color(0xFFFF7746);
  static const Color yakiPrimaryColor = Color(0xFFF2F6F9);
  static const Color teamsDeclarationListBorder =
      Color.fromRGBO(230, 236, 239, 1);
  static const Color teamsDeclarationListDivider =
      Color.fromRGBO(242, 246, 249, 1);
  static const Color remote = Color.fromRGBO(255, 234, 215, 1);
  static const Color onSite = Color.fromRGBO(237, 234, 255, 1);
  static const Color cellChipDefault = Color.fromRGBO(246, 246, 249, 1);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
