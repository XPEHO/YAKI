// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

//import 'widget_test.mocks.dart';

final variant =
    ValueVariant<TargetPlatform>({TargetPlatform.android, TargetPlatform.iOS});

@GenerateMocks([DeclarationApi])
void main() {
  test('super test', () {
    expect(true, true);
  });

  testGoldens('Header must look correct', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [Device.iphone11, Device.phone],
      )
      ..addScenario(
        name: 'Captain',
        widget: Header(
          pictoIcon: 'assets/images/captain.svg',
          pictoPath: 'assets/images/captain.svg',
          headerTitle: tr('captainTitle'),
          headerHint: tr('captainHeaderTitle'),
        ),
      )
      ..addScenario(
        name: 'Declaration',
        widget: Header(
          pictoIcon: 'assets/images/avatar1.svg',
          pictoPath: 'assets/images/unknown.svg',
          headerTitle: tr('headerTitleDecla'),
          headerHint: tr('headerHintDecla'),
        ),
      )
      ..addScenario(
        name: 'Authentication',
        widget: Header(
          pictoIcon: 'assets/images/dots.svg',
          pictoPath: 'assets/images/authent.svg',
          headerTitle: tr('headerTitle'),
          headerHint: tr('headerHint'),
        ),
      );
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'Header');
  });
}
