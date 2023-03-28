import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/presentation/state/notifiers/declaration_notifier.dart';

import 'declaration_notifier_test.mocks.dart';

@GenerateMocks([
  DeclarationRepository,
  LoginRepository,
])
void main() {
  final declarationRepository = MockDeclarationRepository();
  final loginRepository = MockLoginRepository();

  final declarationNotifier = DeclarationNotifier(declarationRepository, loginRepository);

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
            declarationRepository.getDeclaration(returnedTeamMateId.toString(),
            ),
          ).thenAnswer(
            (realInvocation) => Future.value(declarationStatus),
          );
          String notifierStatus = await declarationNotifier.getDeclaration();

          expect(notifierStatus, declarationStatus);
        },
      );
      test(
        'create Declaration method test',
            () async {
          when(loginRepository.teamMateId).thenReturn(returnedTeamMateId);
          declarationNotifier.create(declarationStatus);
        },
      );
    },
  );
}
