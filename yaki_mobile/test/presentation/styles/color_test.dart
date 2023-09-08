import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/styles/color.dart';

void main() {
  group(
    'Color test',
    () {
      test(
          'createMaterialColor should return a MaterialColor with the given color',
          () {
        const Color inputColor = Colors.blue;
        final MaterialColor materialColor = createMaterialColor(inputColor);

        expect(
          materialColor,
          isA<MaterialColor>(),
        );
        expect(
          materialColor.shade500,
          equals(Colors.blue.shade500),
        );
      });

      test('createMaterialColor should handle different input colors', () {
        const Color inputColor = Colors.green;
        final MaterialColor materialColor = createMaterialColor(inputColor);

        expect(materialColor, isA<MaterialColor>());
        expect(
          materialColor.shade500,
          equals(Colors.green.shade500),
        );
      });
    },
  );
}
