import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/presentation/state/notifiers/declaration_notifier.dart';

import 'declaration_notifier_test.mocks.dart';

@GenerateMocks([DeclarationRepository, LoginRepository, TeamRepository])
void main() {
  final declarationRepository = MockDeclarationRepository();
  final loginRepository = MockLoginRepository();
  final teamRepository = MockTeamRepository();

  final declarationNotifier = DeclarationNotifier(
    declarationRepository,
    loginRepository,
    teamRepository,
  );

  int returnedTeamMateId = 1;
  List<String> declarationStatus = ["REMOTE"];

  group(
    'declaration notifier method test',
    () {
      test(
        'getDeclaration method test',
        () async {
          when(loginRepository.userId).thenReturn(returnedTeamMateId);
          when(
            declarationRepository.getDeclaration(
              returnedTeamMateId.toString(),
            ),
          ).thenAnswer(
            (realInvocation) => Future.value(declarationStatus),
          );
          List<String> notifierStatus =
              await declarationNotifier.getDeclaration();

          expect(notifierStatus, declarationStatus);
        },
      );
    },
  );
}
