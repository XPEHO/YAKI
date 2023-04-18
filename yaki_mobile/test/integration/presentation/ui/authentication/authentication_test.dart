import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/app.dart';
import 'package:yaki/data/models/login_model.dart';
import 'package:yaki/data/repositories/login_repository.dart';

import '../../../../unit/data/repositories/login_repository_test.mocks.dart';
import '../../../../unit/mocking.mocks.dart';

void main() async {
  // Mock HTTPResponse
  final httpResponse = MockHttpResponse();
  final response = MockResponse();

  final mockedLoginApi = MockLoginApi();
  final loginRepository = LoginRepository(mockedLoginApi);

  Future<void> initAppWidgetTest(WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(
      {
        'token': '',
        'userId': '',
      },
    );
    await EasyLocalization.ensureInitialized();
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const ProviderScope(child: YakiApp()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pump(
      const Duration(seconds: 2),
    );
  }

  group(
    'Authentification',
    () {
      testWidgets(
        'Show Login Page',
        (WidgetTester tester) async {
          HttpOverrides.global = null;

          await initAppWidgetTest(tester);

          expect(find.text('Sign In'), findsOneWidget);

          // Enter login details
          await tester.enterText(find.byType(TextField).first, 'lavigne');
          await tester.enterText(find.byType(TextField).at(1), 'lavigne');

          // Tap the "Connect" button
          await tester.tap(find.byType(ElevatedButton).first);
          await tester.pumpAndSettle();

          expect(find.text('Captain'), findsOneWidget);
        },
      );
    },
  );
}
