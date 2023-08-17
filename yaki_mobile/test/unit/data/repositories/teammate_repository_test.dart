import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/repositories/teammate_repository.dart';
import 'package:yaki/data/sources/remote/teammate_api.dart';
import 'package:yaki/domain/entities/teammate_entity.dart';

import '../../mocking.mocks.dart';
import 'teammate_repository_test.mocks.dart';

@GenerateMocks([TeammateApi])
void main() {
  // MockHttpResponseList as response is a list.
  final httpResponseList = MockHttpResponseList();
  final response = MockResponse();
  final mockedTeamMateApi = MockTeammateApi();

  final teamMateRepository = TeammateRepository(mockedTeamMateApi);

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

          List<TeammateEntity> teamMatelistReturned = [
            TeammateEntity(
              userFirstName: "Dupond",
              userLastName: "Dupond",
              declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
              declarationStatus: "vacation",
            ),
            TeammateEntity(
              userFirstName: "Jean",
              userLastName: "Val",
              declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
              declarationStatus: "remote",
            ),
          ];

          when(mockedTeamMateApi.getTeammate(captainId)).thenAnswer(
            (realInvocation) => Future.value(httpResponseList),
          );
          when(httpResponseList.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponseList.data).thenReturn(getResponseAsJson);

          List<TeammateEntity> teamMatelist =
              await teamMateRepository.getTeammate(captainId);

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

          when(mockedTeamMateApi.getTeammate(incorrectCaptainId)).thenAnswer(
            (realInvocation) => Future.value(httpResponseList),
          );
          when(httpResponseList.response).thenReturn(response);
          when(response.statusCode).thenReturn(404);
          when(httpResponseList.data).thenReturn(incorrectResponse);

          List<TeammateEntity> teamMatelist =
              await teamMateRepository.getTeammate(incorrectCaptainId);

          expect(listEquals(teamMatelist, []), true);
        },
      );
    },
  );
}
