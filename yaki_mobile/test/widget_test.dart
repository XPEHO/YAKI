// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/sources/declaration_api.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([DeclarationApi])
void main() {
  test('create declaration return a declaration', () async {
    // GIVEN
    final mockedApi = MockDeclarationApi();
    final repository = DeclarationRepository(mockedApi);

    final declarationSent = DeclarationModel(
        declarationDate: DateTime.now(),
        declarationTeamMateId: 1,
        declarationStatus: 'On Site');

    when(mockedApi.create(declarationSent))
        .thenAnswer((realInvocation) => Future.value(declarationSent));

    // WHEN
    final DeclarationModel declaration =
        await repository.create(declarationSent);

    // THEN
    expect(declaration, declarationSent);
  });
}
