import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/ui/shared/views/input_app.dart';

void main() {
  group("Input app", () {
    testWidgets(
      'Success',
      (widgetTester) async {
        const inputText = 'Hello World';
        const inputHint = 'Hint';
        const password = true;
        final controller = TextEditingController();
        const defaultValue = '';

        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InputApp(
                inputText: inputText,
                inputHint: inputHint,
                password: password,
                controller: controller,
                defaultValue: defaultValue,
              ),
            ),
          ),
        );

        expect(find.text(inputText), findsOneWidget);

        // Search icon button and check the icon
        expect(find.byIcon(Icons.visibility), findsOneWidget);
        expect(find.byIcon(Icons.visibility_off), findsNothing);
      },
    );

    testWidgets(
      'Check the password visibility icon',
      (widgetTester) async {
        const inputText = 'Hello World';
        const inputHint = 'Hint';
        const password = true;
        final controller = TextEditingController();
        const defaultValue = '';

        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InputApp(
                inputText: inputText,
                inputHint: inputHint,
                password: password,
                controller: controller,
                defaultValue: defaultValue,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.visibility), findsOneWidget);
        expect(find.byIcon(Icons.visibility_off), findsNothing);

        await widgetTester.tap(
          find.byType(
            IconButton,
          ),
        );
        await widgetTester.pump();

        expect(find.byIcon(Icons.visibility), findsNothing);
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      },
    );
  });
}
