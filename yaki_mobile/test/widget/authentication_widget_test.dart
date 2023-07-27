import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/ui/authentication/authentication.dart';

void main() {
  testWidgets(
    'Login Screen standard test',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Authentication(),
        ),
      );

      final loginFinder = find.text('inputLogin');
      expect(loginFinder, findsOneWidget);

      final passwordFinder = find.text('inputPassword');
      expect(passwordFinder, findsOneWidget);

      final signInButtonFinder = find.text('signIn');
      expect(signInButtonFinder, findsOneWidget);

      // tap on InputApp inputLogin
      final loginFieldFinder = find.bySemanticsLabel(RegExp(r'hintLogin'));
      expect(loginFieldFinder, findsOneWidget);
      await widgetTester.tap(loginFieldFinder);
      await widgetTester.pumpAndSettle();
      // type login
      await widgetTester.enterText(loginFieldFinder, 'login');

      // tap on InputApp inputPassword
      final passwordFieldFinder =
          find.bySemanticsLabel(RegExp(r'hintPassword'));
      expect(passwordFieldFinder, findsOneWidget);
      await widgetTester.tap(passwordFieldFinder);
      await widgetTester.pumpAndSettle();
      // type password
      await widgetTester.enterText(passwordFieldFinder, 'password');

      // Tap on Sign in
      final signInButton = find.byType(ElevatedButton);
      expect(signInButton, findsOneWidget);
      await widgetTester.tap(signInButton);
    },
  );
}
