import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/ui/shared/views/confirmation_elevated_button.dart';

void main() {
  group('Confirmation elevated button', () {
    testWidgets('should display the text', (WidgetTester widgetTester) async {
      const text = 'Confirm';

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ConfirmationElevatedButton(
              text: text,
              onPressed: () {},
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              btnTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(text), findsOneWidget);
    });

    testWidgets('should call onPressed when button is pressed',
        (WidgetTester widgetTester) async {
      var isPressed = false;

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ConfirmationElevatedButton(
              text: 'Confirm',
              onPressed: () => isPressed = true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              btnTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();

      expect(isPressed, true);
    });
  });
}
