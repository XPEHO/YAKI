// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:yaki/data/repositories/declaration_respository.dart';
// import 'package:yaki/data/repositories/login_repository.dart';
// import 'package:yaki/data/repositories/team_repository.dart';
// import 'package:yaki/presentation/state/notifiers/declaration_notifier.dart';
// import 'package:yaki/presentation/state/providers/declaration_provider.dart';
// import 'package:yaki/presentation/state/providers/login_provider.dart';
// import 'package:yaki/presentation/state/providers/team_provider.dart';

// import 'declaration_notifier_test.mocks.dart';

// @GenerateMocks([DeclarationRepository, LoginRepository, TeamRepository])
// void main() {
//   final declarationRepository = MockDeclarationRepository();
//   final loginRepository = MockLoginRepository();
//   final teamRepository = MockTeamRepository();

//   // final declarationNotifier = DeclarationNotifier(
//   //   declarationRepository,
//   //   loginRepository,
//   //   teamRepository,
//   // );

//   // int returnedTeamMateId = 1;
//   // List<String> declarationStatus = ["REMOTE"];

//   group(
//     'declaration notifier method test',
//     () {
//       // test(
//       //   'getDeclaration method test',
//       //   () async {
//       //     when(loginRepository.userId).thenReturn(returnedTeamMateId);
//       //     when(
//       //       declarationRepository.getLatestDeclaration(
//       //         returnedTeamMateId.toString(),
//       //       ),
//       //     ).thenAnswer(
//       //       (realInvocation) => Future.value(declarationStatus),
//       //     );
//       //     List<String> notifierStatus =
//       //         await declarationNotifier.getLatestDeclaration();

//       //     expect(notifierStatus, declarationStatus);
//       //   },
//       // );

//       test(
//         'test with ProviderContainer',
//         () async {
//           final container = ProviderContainer(
//             overrides: [
//               declarationRepositoryProvider.overrideWithValue(
//                 declarationRepository,
//               ),
//               loginRepositoryProvider.overrideWithValue(
//                 loginRepository,
//               ),
//               teamRepositoryProvider.overrideWithValue(
//                 teamRepository,
//               ),
//             ],
//           );

//           final notifier = container.read(declarationProvider.notifier);

//           final status = await notifier.getLatestDeclaration();

//           expect(status, declarationStatus);
//         },
//       );
//     },
//   );
// }
