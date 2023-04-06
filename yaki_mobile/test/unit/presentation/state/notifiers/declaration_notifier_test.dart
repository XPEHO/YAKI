import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';
import 'package:yaki/presentation/state/notifiers/declaration_notifier.dart';

import 'declaration_notifier_test.mocks.dart';

@GenerateMocks([
  DeclarationRepository,
  LoginRepository,
])
void main() {
  final declarationRepository = MockDeclarationRepository();
  final loginRepository = MockLoginRepository();

  final declarationNotifier = DeclarationNotifier(
    declarationRepository,
    loginRepository,
  );

  int returnedTeamMateId = 1;
  String declarationStatus = "REMOTE";

  group(
    'declaration notifier method test',
    () {
      test(
        'getDeclaration method test',
        () async {
          when(loginRepository.teamMateId).thenReturn(returnedTeamMateId);
          when(
            declarationRepository.getDeclaration(
              returnedTeamMateId.toString(),
            ),
          ).thenAnswer(
            (realInvocation) => Future.value(declarationStatus),
          );
          String notifierStatus = await declarationNotifier.getDeclaration();

          expect(notifierStatus, declarationStatus);
        },
      );

      test('create should send declaration to repository', () async {
        // GIVEN
        final status = StatusEnum.remote.name;

        when(loginRepository.teamMateId).thenReturn(returnedTeamMateId);

        DeclarationModel expectedDeclarationModel = DeclarationModel(
          declarationDate: DateTime.now(),
          declarationTeamMateId: loginRepository.teamMateId,
          declarationStatus: status,
        );

        // WHEN
        await declarationNotifier.create(status);

        // THEN
        final passedArgument =
            verify(declarationRepository.create(captureAny)).captured.single;
        expect(
          passedArgument is DeclarationModel,
          true,
        );
        DeclarationModel passedDeclarationModel = passedArgument;
        expect(
          passedDeclarationModel.declarationStatus,
          expectedDeclarationModel.declarationStatus,
        );
        expect(
          passedDeclarationModel.declarationTeamMateId,
          expectedDeclarationModel.declarationTeamMateId,
        );
      });
    },
  );
}
