// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GoldenGenerator
// **************************************************************************

part of 'declaration_golden_test.dart';

lookGoldens() => group(
      'Declaration golden tests',
      () {
        testWidgets(
          '400x600 Declaration light theme',
          (WidgetTester tester) async {
            tester.binding.window.physicalSizeTestValue = const Size(
              400.0,
              600.0,
            );
            await tester.pumpWidget(
              MaterialApp(
                theme: ThemeData(),
                home: buildDeclarationLook(),
              ),
            );
            await expectLater(
              find.byType(Declaration),
              matchesGoldenFile('goldens/declaration_golden_400x600_.png'),
            );
          },
        );
        testWidgets(
          '800x600 Declaration light theme',
          (WidgetTester tester) async {
            tester.binding.window.physicalSizeTestValue = const Size(
              800.0,
              600.0,
            );
            await tester.pumpWidget(
              MaterialApp(
                theme: ThemeData(),
                home: buildDeclarationLook(),
              ),
            );
            await expectLater(
              find.byType(Declaration),
              matchesGoldenFile('goldens/declaration_golden_800x600_.png'),
            );
          },
        );
        testWidgets(
          '800x1200 Declaration light theme',
          (WidgetTester tester) async {
            tester.binding.window.physicalSizeTestValue = const Size(
              800.0,
              1200.0,
            );
            await tester.pumpWidget(
              MaterialApp(
                theme: ThemeData(),
                home: buildDeclarationLook(),
              ),
            );
            await expectLater(
              find.byType(Declaration),
              matchesGoldenFile('goldens/declaration_golden_800x1200_.png'),
            );
          },
        );
        testWidgets(
          '1600x1200 Declaration light theme',
          (WidgetTester tester) async {
            tester.binding.window.physicalSizeTestValue = const Size(
              1600.0,
              1200.0,
            );
            await tester.pumpWidget(
              MaterialApp(
                theme: ThemeData(),
                home: buildDeclarationLook(),
              ),
            );
            await expectLater(
              find.byType(Declaration),
              matchesGoldenFile('goldens/declaration_golden_1600x1200_.png'),
            );
          },
        );
      },
    );
