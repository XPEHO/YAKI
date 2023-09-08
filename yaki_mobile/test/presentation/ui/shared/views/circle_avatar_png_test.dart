import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_png.dart';

void main() {
  testWidgets('Circle avatar png', (widgetTester) async {
    const iconPath = "assets/images/authent.png";

    await widgetTester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CircleAvatarPNG(
            iconPath: iconPath,
            radius: 20,
          ),
        ),
      ),
    );

    final circleAvatarPNGFinder = find.byType(CircleAvatarPNG);
    final circleAvatarPNGWidget =
        circleAvatarPNGFinder.evaluate().single.widget as CircleAvatarPNG;
    expect(
      circleAvatarPNGWidget,
      isA<CircleAvatarPNG>(),
    );
    expect(circleAvatarPNGWidget.radius, 20);
  });
}
