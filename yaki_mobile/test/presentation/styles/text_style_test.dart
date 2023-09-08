import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/styles/text_style.dart';

void main() {
  group('Text style', () {
    testWidgets('Header big', (widgetTester) async {
      const text = 'Header big';

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              text,
              style: textStyleHeaderBig(),
            ),
          ),
        ),
      );

      final textFinder = find.text(text);
      final textWidget = textFinder.evaluate().single.widget as Text;
      final textStyle = textWidget.style;
      expect(textStyle?.fontSize, 20);
    });

    testWidgets('Header small', (widgetTester) async {
      const text = 'Header small';

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              text,
              style: textStyleHeaderSmall(),
            ),
          ),
        ),
      );

      final textFinder = find.text(text);
      final textWidget = textFinder.evaluate().single.widget as Text;
      final textStyle = textWidget.style;
      expect(textStyle?.fontSize, 17);
    });

    testWidgets('Registration page title', (widgetTester) async {
      const text = 'Registration page title';

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              text,
              style: registrationPageTitleTextStyle(),
            ),
          ),
        ),
      );

      final textFinder = find.text(text);
      final textWidget = textFinder.evaluate().single.widget as Text;
      final textStyle = textWidget.style;
      expect(textStyle?.fontSize, 25);
    });

    testWidgets('Registration button title', (widgetTester) async {
      const text = 'Registration button title';

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              text,
              style: registrationBtnTextStyle(),
            ),
          ),
        ),
      );

      final textFinder = find.text(text);
      final textWidget = textFinder.evaluate().single.widget as Text;
      final textStyle = textWidget.style;
      expect(textStyle?.fontSize, 25);
      expect(textStyle?.color, Colors.black);
    });

    testWidgets('Registration cancel title', (widgetTester) async {
      const text = 'Registration cancel title';

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              text,
              style: registrationCancelTextStyle(),
            ),
          ),
        ),
      );

      final textFinder = find.text(text);
      final textWidget = textFinder.evaluate().single.widget as Text;
      final textStyle = textWidget.style;
      expect(textStyle?.fontSize, 25);
      expect(textStyle?.fontWeight, FontWeight.w600);
      expect(textStyle?.color, const Color.fromARGB(255, 231, 229, 229));
    });

    testWidgets('Registration snack title', (widgetTester) async {
      const text = 'Registration snack title';
      const colorSelected = Colors.red;

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              text,
              style: registratonSnackTextStyle(
                textColor: colorSelected,
              ),
            ),
          ),
        ),
      );

      final textFinder = find.text(text);
      final textWidget = textFinder.evaluate().single.widget as Text;
      final textStyle = textWidget.style;
      expect(textStyle?.fontSize, 15);
      expect(textStyle?.fontWeight, FontWeight.bold);
      expect(textStyle?.color, colorSelected);
    });

    testWidgets('User redirect', (widgetTester) async {
      const text = 'User redirect';

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              text,
              style: textStyleUserRedirectStyle(),
            ),
          ),
        ),
      );

      final textFinder = find.text(text);
      final textWidget = textFinder.evaluate().single.widget as Text;
      final textStyle = textWidget.style;
      expect(textStyle?.fontSize, 18);
      expect(textStyle?.fontWeight, FontWeight.bold);
    });

    testWidgets('User team redirect', (widgetTester) async {
      const text = 'User team redirect';

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              text,
              style: textStyleUserRedirectStyleTeam(),
            ),
          ),
        ),
      );

      final textFinder = find.text(text);
      final textWidget = textFinder.evaluate().single.widget as Text;
      final textStyle = textWidget.style;
      expect(textStyle?.fontSize, 20);
      expect(textStyle?.fontWeight, FontWeight.bold);
    });
  });
}
