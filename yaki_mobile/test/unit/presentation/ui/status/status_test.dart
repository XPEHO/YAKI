import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';
import 'package:yaki/presentation/state/notifiers/status_notifier.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/ui/status/status.dart';

import '../../state/notifiers/declaration_notifier_test.mocks.dart';

void main() {
  testWidgets(
    'StatusPage should fetch selected status',
    (WidgetTester tester) async {
      // GIVEN
      final declarationRepository = MockDeclarationRepository();
      const statusPage = Status();

      when(declarationRepository.status).thenReturn(StatusEnum.remote.name);

      // WHEN
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            statusPageProvider.overrideWith(
              (ref) {
                return StatusPageNotifier(declarationRepository)
                  ..getSelectedStatus();
              },
            ),
          ],
          child: const MaterialApp(
            home: statusPage,
          ),
        ),
      );

      // THEN
      expect(find.byType(Status), findsOneWidget);
      expect(find.text('StatusRemote'), findsOneWidget);
    },
  );
}
