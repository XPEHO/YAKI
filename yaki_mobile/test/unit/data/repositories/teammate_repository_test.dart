import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/repositories/teammate_repository.dart';
import 'package:yaki/data/sources/remote/teammate_api.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

import '../../mocking.mocks.dart';
import 'teammate_repository_test.mocks.dart';

@GenerateMocks([TeammateApi])
void main() {
  // MockHttpResponseList as response is a list.
  final httpResponseList = MockHttpResponseList();
  final response = MockResponse();
  final mockedTeamMateApi = MockTeammateApi();

  final teamMateRepository = TeammateRepository(mockedTeamMateApi);

  SharedPreferences.setMockInitialValues(
    {
      'token': '',
      'userId': 34,
    },
  );

  group(
    'Get() teamate list',
    () {
      test(
        'GetTeammate testing',
        () async {
          int userId = 34;
          List<Map<String, dynamic>> getResponseAsJson = [
            {
              "userId": 1,
              "userFirstName": "Dupond",
              "userLastName": "Dupond",
              "declarationDate": '2023-03-20T10:00:00.950Z',
              "declarationDateStart": '2023-03-20T03:00:00.950Z',
              "declarationDateEnd": '2023-03-20T23:00:00.950Z',
              "declarationStatus": "remote",
              "teamId": 1,
              "teamName": "teamName",
              "declarationId": 1,
              "declarationUserId": 1,
              "avatarReference": null,
              "avatar": null,
            },
            {
              "userId": 2,
              "userFirstName": "Jean",
              "userLastName": "Val",
              "declarationDate": '2023-03-20T10:00:00.950Z',
              "declarationDateStart": '2023-03-20T03:00:00.950Z',
              "declarationDateEnd": '2023-03-20T23:00:00.950Z',
              "declarationStatus": "remote",
              "teamId": 1,
              "teamName": "teamName",
              "declarationId": 2,
              "declarationUserId": 2,
              "avatarReference": null,
              "avatar": null,
            }
          ];

          List<TeammateWithDeclarationEntity> teamMatelistReturned = [
            TeammateWithDeclarationEntity(
              loggedUserId: 34,
              userId: 1,
              userFirstName: "Dupond",
              userLastName: "Dupond",
              declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
              declarationDateStart: DateTime.parse('2023-03-20T03:00:00.950Z'),
              declarationDateEnd: DateTime.parse('2023-03-20T23:00:00.950Z'),
              declarationStatus: StatusEnum.fromValue("remote"),
              teamId: 1,
              teamName: "teamName",
              customerId: null,
              customerName: null,
              avatarReference: null,
              avatar: null,
            ),
            TeammateWithDeclarationEntity(
              loggedUserId: 34,
              userId: 2,
              userFirstName: "Jean",
              userLastName: "Val",
              declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
              declarationDateStart: DateTime.parse('2023-03-20T03:00:00.950Z'),
              declarationDateEnd: DateTime.parse('2023-03-20T23:00:00.950Z'),
              declarationStatus: StatusEnum.fromValue("remote"),
              teamId: 1,
              teamName: "teamName",
              customerId: null,
              customerName: null,
              avatarReference: null,
              avatar: null,
            ),
          ];

          when(mockedTeamMateApi.getTeammate(userId)).thenAnswer(
            (realInvocation) => Future.value(httpResponseList),
          );

          when(httpResponseList.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponseList.data).thenReturn(getResponseAsJson);

          List<TeammateWithDeclarationEntity> teamMatelist =
              await teamMateRepository.getTeammate();

          expect(teamMatelist, equals(teamMatelistReturned));
        },
      );
      test(
        'throw  exception',
        () async {
          int incorrectUserId = 50;
          List<Map<String, dynamic>> incorrectResponse = [
            {
              "message": "no list",
            }
          ];

          when(mockedTeamMateApi.getTeammate(incorrectUserId)).thenAnswer(
            (realInvocation) => Future.value(httpResponseList),
          );
          when(httpResponseList.response).thenReturn(response);
          when(response.statusCode).thenReturn(404);
          when(httpResponseList.data).thenReturn(incorrectResponse);

          try {
            await teamMateRepository.getTeammate();
          } catch (error) {
            expect(error, isA<Exception>());
          }
        },
      );
    },
  );
}
