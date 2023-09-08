import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/ui/shared/views/avatar_icon.dart';

void main() {
  group('Avatar icon', () {
    testWidgets('Success', (widgetTester) async {
      bool isPressed = false;

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarIcon(
              pictoIcon: "assets/images/exit.svg",
              onPressed: () {
                debugPrint("Avatar icon pressed");
                isPressed = true;
              },
            ),
          ),
        ),
      );

      final avatarIconFinder = find.byType(AvatarIcon);
      final avatarIconWidget =
          avatarIconFinder.evaluate().single.widget as AvatarIcon;
      expect(
        avatarIconWidget,
        isA<AvatarIcon>(),
      );
      expect(find.byType(SvgPicture), findsOneWidget);

      await widgetTester.tap(avatarIconFinder);

      expect(isPressed, true);
    });
  });
}
