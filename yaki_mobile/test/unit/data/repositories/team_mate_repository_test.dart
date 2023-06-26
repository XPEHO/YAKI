import 'package:flutter/foundation.dart';
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
  // MockHttpResponseList as response is a list.
  final httpResponseList = MockHttpResponseList();
  final response = MockResponse();
  final mockedTeamMateApi = MockTeamMateApi();

  final teamMateRepository = TeamMateRepository(mockedTeamMateApi);

  group(
    'Get() teamate list',
    () {
      test(
        'GetTeammate testing',
        () async {
          String captainId = "1";
          List<Map<String, dynamic>> getResponseAsJson = [
            {
              "userId": 1,
              "userFirstName": "Dupond",
              "userLastName": "Dupond",
              "declarationDate": '2023-03-20T10:00:00.950Z',
              "declarationStatus": "vacation",
            },
            {
              "userId": 2,
              "userFirstName": "Jean",
              "userLastName": "Val",
              "declarationDate": '2023-03-20T10:00:00.950Z',
              "declarationStatus": "remote",
            }
          ];

          List<TeamMateEntity> teamMatelistReturned = [
            TeamMateEntity(
              userFirstName: "Dupond",
              userLastName: "Dupond",
              declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
              declarationStatus: "vacation",
            ),
            TeamMateEntity(
              userFirstName: "Jean",
              userLastName: "Val",
              declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
              declarationStatus: "remote",
            )
          ];

          when(mockedTeamMateApi.getTeamMate(captainId)).thenAnswer(
            (realInvocation) => Future.value(httpResponseList),
          );
          when(httpResponseList.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponseList.data).thenReturn(getResponseAsJson);

          List<TeamMateEntity> teamMatelist =
              await teamMateRepository.getTeamMate(captainId);

          expect(listEquals(teamMatelist, teamMatelistReturned), true);
        },
      );
      test(
        'throw  exception',
        () async {
          String incorrectCaptainId = "50";
          List<Map<String, dynamic>> incorrectResponse = [
            {
              "message": "no list",
            }
          ];

          when(mockedTeamMateApi.getTeamMate(incorrectCaptainId)).thenAnswer(
            (realInvocation) => Future.value(httpResponseList),
          );
          when(httpResponseList.response).thenReturn(response);
          when(response.statusCode).thenReturn(404);
          when(httpResponseList.data).thenReturn(incorrectResponse);

          List<TeamMateEntity> teamMatelist =
              await teamMateRepository.getTeamMate(incorrectCaptainId);

          expect(listEquals(teamMatelist, []), true);
        },
      );
    },
  );
}
