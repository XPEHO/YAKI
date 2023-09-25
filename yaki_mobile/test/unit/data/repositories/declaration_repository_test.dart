import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/domain/entities/delcaration_entity_in.dart';
import '../../mocking.mocks.dart';
import 'declaration_repository_test.mocks.dart';

@GenerateMocks([DeclarationApi])
void main() {
  final httpResponse = MockHttpResponseList();
  final response = MockResponse();
  final mockedDeclarationApi = MockDeclarationApi();
  final declarationRepository = DeclarationRepository(mockedDeclarationApi);
  final List<Map<String, dynamic>> createResponseApi = [
    {
      "declarationId": 2,
      "declarationUserId": 3,
      "declarationDate": DateTime.now().toIso8601String(),
      "declarationDateStart": DateTime.now().toIso8601String(),
      "declarationDateEnd": DateTime.now().toIso8601String(),
      "declarationStatus": "REMOTE",
      "declarationTeamId": 2,
    },
  ];
  final List<Map<String, dynamic>> createHalfDayResponseApi = [
    {
      "declarationId": 2,
      "declarationUserId": 3,
      "declarationDate": DateTime.now().toIso8601String(),
      "declarationDateStart": DateTime.now().toIso8601String(),
      "declarationDateEnd": DateTime.now().toIso8601String(),
      "declarationStatus": "REMOTE",
      "declarationTeamId": 2,
    },
    {
      "declarationId": 2,
      "declarationUserId": 3,
      "declarationDate": DateTime.now().toIso8601String(),
      "declarationDateStart": DateTime.now().toIso8601String(),
      "declarationDateEnd": DateTime.now().toIso8601String(),
      "declarationStatus": "OTHER",
      "declarationTeamId": 2,
    },
  ];

  group(
    'declaration repository getDeclaration()',
    () {
      const int teammateId = 1;
      final List<Map<String, dynamic>> getErrorResponse = [{}];
      test(
        'Successfully GET daily declaration.',
        () async {
          // Stubbing
          when(mockedDeclarationApi.getDeclaration(teammateId)).thenAnswer(
            (realInvocation) => Future.value(httpResponse),
          );
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponse.data).thenReturn(createResponseApi);

          final DeclarationEntityIn status =
              await declarationRepository.getLatestDeclaration(teammateId);

          expect(status.fullDayStatus, ["REMOTE"]);
        },
      );
      test(
        'Fail to get the last declaration, or no daily declaration.',
        () async {
          // Stubbing
          when(mockedDeclarationApi.getDeclaration(teammateId)).thenAnswer(
            (realInvocation) => Future.value(httpResponse),
          );
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(404);
          when(httpResponse.data).thenReturn(getErrorResponse);

          final DeclarationEntityIn status =
              await declarationRepository.getLatestDeclaration(teammateId);

          expect(status.fullDayStatus, []);
        },
      );
      test(
        'throw exception when get declaration',
        () async {
          // Stubbing
          when(mockedDeclarationApi.getDeclaration(teammateId))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(418);
          when(httpResponse.data).thenReturn(getErrorResponse);

          final DeclarationEntityIn status =
              await declarationRepository.getLatestDeclaration(teammateId);

          expect(status.fullDayStatus, []);
        },
      );
    },
  );
  group(
    'Declaration allDay respository create()',
    () {
      DeclarationModel createdDeclaration = DeclarationModel(
        declarationUserId: 1,
        declarationDate: DateTime.now(),
        declarationDateStart: DateTime.parse('2023-03-20T00:00:00.000Z'),
        declarationDateEnd: DateTime.parse('2023-03-20T23:59:59.950Z'),
        declarationStatus: "REMOTE",
        declarationTeamId: 2,
      );
      test(
        'Successfully create declaration.',
        () async {
          when(mockedDeclarationApi.create([createdDeclaration], 'fullDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200 | 201);
          when(httpResponse.data).thenReturn(createResponseApi);
          final returnedValue =
              await declarationRepository.createFullDay(createdDeclaration);
          expect(returnedValue, 'REMOTE');
        },
      );
      test(
        'Fail create declaration 400 or 500.',
        () async {
          when(mockedDeclarationApi.create([createdDeclaration], 'fullDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(400 | 500);
          when(httpResponse.data).thenReturn(createResponseApi);
          final returnedValue =
              await declarationRepository.createFullDay(createdDeclaration);
          expect(returnedValue, '');
        },
      );
      test(
        'Fail create declaration 401.',
        () async {
          when(mockedDeclarationApi.create([createdDeclaration], 'fullDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(401);
          when(httpResponse.data).thenReturn(createResponseApi);
          final returnedValue =
              await declarationRepository.createFullDay(createdDeclaration);
          expect(returnedValue, '');
        },
      );
      test(
        'Fail create declaration 403.',
        () async {
          when(mockedDeclarationApi.create([createdDeclaration], 'fullDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(403);
          when(httpResponse.data).thenReturn(createResponseApi);
          final returnedValue =
              await declarationRepository.createFullDay(createdDeclaration);
          expect(returnedValue, '');
        },
      );
      test(
        'Throw exception when create declaration',
        () async {
          when(mockedDeclarationApi.create([createdDeclaration], 'fullDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(418);
          when(httpResponse.data).thenReturn(createResponseApi);
          final returnedValue =
              await declarationRepository.createFullDay(createdDeclaration);
          expect(returnedValue, '');
        },
      );
    },
  );
  group(
    'Declaration halfDay respository create()',
    () {
      final DeclarationModel declarationMorning = DeclarationModel(
        declarationUserId: 123,
        declarationDate: DateTime.utc(2023, 4, 26),
        declarationDateStart: DateTime.utc(2023, 4, 26, 00),
        declarationDateEnd: DateTime.utc(2023, 4, 26, 12),
        declarationStatus: 'remote',
        declarationTeamId: 2,
      );
      final DeclarationModel declarationAfternoon = DeclarationModel(
        declarationUserId: 123,
        declarationDate: DateTime.utc(2023, 4, 26),
        declarationDateStart: DateTime.utc(2023, 4, 26, 13),
        declarationDateEnd: DateTime.utc(2023, 4, 26, 23),
        declarationStatus: 'other',
        declarationTeamId: 2,
      );
      final List<DeclarationModel> declarations = [
        declarationMorning,
        declarationAfternoon,
      ];
      test(
        'should set declaration status after creating declarations',
        () async {
          // Mock the API's create method to return the response defined above
          when(mockedDeclarationApi.create(declarations, 'halfDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          // Simulate the response of the API
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200 | 201);
          when(httpResponse.data).thenReturn(createHalfDayResponseApi);

          // Call the function to create a half-day declaration
          final List<String> returnedValue =
              await declarationRepository.createHalfDay(declarations);
          // Verify that the declaration status is correctly updated
          expect(
            returnedValue,
            ['REMOTE', 'OTHER'],
          );
        },
      );
      test(
        'Fail create declaration 400 or 500.',
        () async {
          // Mock the API's create method to return the response defined above
          when(mockedDeclarationApi.create(declarations, 'halfDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          // Simulate the response of the API
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(400 | 500);
          when(httpResponse.data).thenReturn(createResponseApi);

          // Call the function to create a half-day declaration
          final returnedValue =
              await declarationRepository.createHalfDay(declarations);
          // Verify that the declaration status is not updated
          expect(
            returnedValue,
            [],
          );
        },
      );
      test(
        'Fail create declaration 401.',
        () async {
          when(mockedDeclarationApi.create(declarations, 'halfDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(401);
          when(httpResponse.data).thenReturn(createResponseApi);

          final returnedValue =
              await declarationRepository.createHalfDay(declarations);
          expect(
            returnedValue,
            [],
          );
        },
      );
      test('Fail create declaration 403.', () async {
        when(mockedDeclarationApi.create(declarations, 'halfDay'))
            .thenAnswer((realInvocation) => Future.value(httpResponse));
        when(httpResponse.response).thenReturn(response);
        when(response.statusCode).thenReturn(403);
        when(httpResponse.data).thenReturn(createResponseApi);

        final returnedValue =
            await declarationRepository.createHalfDay(declarations);
        expect(
          returnedValue,
          [],
        );
      });
    },
  );
}
