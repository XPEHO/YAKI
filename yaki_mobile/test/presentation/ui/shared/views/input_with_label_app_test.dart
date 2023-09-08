import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/ui/shared/views/input_with_label_app.dart';

void main() {
  group('Input with label app', () {
    testWidgets('Success', (WidgetTester widgetTester) async {
      const label = 'Hello';

      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InputWithLabelApp(
              label: label,
            ),
          ),
        ),
      );

      expect(find.text(label), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
