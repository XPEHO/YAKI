import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/ui/shared/views/avatar_icon.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

void main() {
  group('Header', () {
    testWidgets(
      'Success',
      (widgetTester) async {
        const pictoPath = 'assets/images/onSite.svg';
        const headerTitle = 'Hello World';
        const headerHint = 'Hint';
        const pictoIcon = 'assets/images/dots.svg';

        await widgetTester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Header(
                pictoPath: pictoPath,
                headerTitle: headerTitle,
                headerHint: headerHint,
                pictoIcon: pictoIcon,
              ),
            ),
          ),
        );

        expect(find.byType(Container), findsWidgets);
        expect(find.byType(AvatarIcon), findsOneWidget);
        expect(
          find.byType(CircleAvatarSVG),
          findsNWidgets(2),
        );
      },
    );

    testWidgets(
      'With pictoIcon empty',
      (widgetTester) async {
        const pictoPath = 'assets/images/onSite.svg';
        const headerTitle = 'Hello World';
        const headerHint = 'Hint';

        await widgetTester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Header(
                pictoPath: pictoPath,
                headerTitle: headerTitle,
                headerHint: headerHint,
                pictoIcon: '',
              ),
            ),
          ),
        );

        final avatarIcon = find.byType(AvatarIcon);
        final avatarWidget = widgetTester.widget<AvatarIcon>(avatarIcon);

        expect(avatarWidget.pictoIcon, 'assets/images/dots.svg');
      },
    );

    testWidgets(
      'With onPressed',
      (widgetTester) async {
        const pictoPath = 'assets/images/onSite.svg';
        const headerTitle = 'Hello World';
        const headerHint = 'Hint';
        const pictoIcon = 'assets/images/dots.svg';

        bool isPressed = false;

        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Header(
                pictoPath: pictoPath,
                headerTitle: headerTitle,
                headerHint: headerHint,
                pictoIcon: pictoIcon,
                onPressed: () {
                  debugPrint('onPressed');
                  isPressed = true;
                },
              ),
            ),
          ),
        );
        await widgetTester.tap(find.byType(AvatarIcon));
        await widgetTester.pump();

        expect(isPressed, true);
      },
    );
  });
}
