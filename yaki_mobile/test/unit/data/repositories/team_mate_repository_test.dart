import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/repositories/team_mate_repository.dart';
import 'package:yaki/data/sources/remote/team_mate_api.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';

import '../../mocking.mocks.dart';
import 'team_mate_repository_test.mocks.dart';

@GenerateMocks([TeamMateApi])
void main() {
  final httpResponse = MockHttpResponse();
  final response = MockResponse();
  final mockedTeamMateApi = MockTeamMateApi();

  final teamMateRepository = TeamMateRepository(mockedTeamMateApi);

  dynamic getResponseAsJson = [
    {
      "userFirstName": "Dupond",
      "userLastName": "Dupond",
      "declarationDate": '2023-03-20T10:00:00.950Z',
      "declarationStatus": "VACATION",
    },
    {
      "userFirstName": "Jean",
      "userLastName": "Val",
      "declarationDate": '2023-03-20T10:00:00.950Z',
      "declarationStatus": "REMOTE",
    }
  ];

  List<TeamMateEntity> teamMatelistReturned = [
    TeamMateEntity(
      userFirstName: "Dupond",
      userLastName: "Dupond",
      declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
      declarationStatus: "VACATION",
    ),
    TeamMateEntity(
      userFirstName: "Jean",
      userLastName: "Val",
      declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
      declarationStatus: "REMOTE",
    )
  ];

  String captainId = "1";

  group(
    'Get() teamate list',
    () {
      test(
        'GetTeammate testing',
        () async {
          when(mockedTeamMateApi.getTeamMate(captainId))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.data).thenReturn(expected)

          List<TeamMateEntity> teamMatelist =
              await teamMateRepository.getTeamMate(captainId);

          expect(teamMatelist, teamMatelistReturned);
        },
      );
    },
  );
}
