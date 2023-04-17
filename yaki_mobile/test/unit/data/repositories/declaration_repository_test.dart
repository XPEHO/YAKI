import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
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
      "declarationDate": DateTime.now().toIso8601String(),
      "declarationDateStart": DateTime.now().toIso8601String(),
      "declarationDateEnd": DateTime.now().toIso8601String(),
      "declarationTeamMateId": 3,
      "declarationStatus": "REMOTE"
    },
  ];
  group(
    'declaration repository getDeclaration()',
    () {
      const String teammateId = "1";
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
          final String status =
              await declarationRepository.getDeclaration(teammateId);
          expect(status, "REMOTE");
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
          final String status =
              await declarationRepository.getDeclaration(teammateId);
          expect(status, "");
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
          final String status =
              await declarationRepository.getDeclaration(teammateId);
          expect(status, "");
        },
      );
    },
  );
  group(
    'Declaration allDay respository create()',
    () {
      DeclarationModel createdDeclaration = DeclarationModel(
        declarationDate: DateTime.now(),
        declarationDateStart: DateTime.parse('2023-03-20T00:00:00.000Z'),
        declarationDateEnd: DateTime.parse('2023-03-20T23:59:59.950Z'),
        declarationTeamMateId: 1,
        declarationStatus: "REMOTE",
      );
      test(
        'Successfully create declaration.',
        () async {
          when(mockedDeclarationApi.create([createdDeclaration], 'fullDay'))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200 | 201);
          when(httpResponse.data).thenReturn(createResponseApi);
          await declarationRepository.createAllDay(createdDeclaration);
          expect(declarationRepository.statusAllDay, "REMOTE");
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
          await declarationRepository.createAllDay(createdDeclaration);
          expect(declarationRepository.statusAllDay, "");
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
          await declarationRepository.createAllDay(createdDeclaration);
          expect(declarationRepository.statusAllDay, "");
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
          await declarationRepository.createAllDay(createdDeclaration);
          expect(declarationRepository.statusAllDay, "");
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
          await declarationRepository.createAllDay(createdDeclaration);
          expect(declarationRepository.statusAllDay, "");
        },
      );
    },
  );
  group(
    'annexe function',
    () {
      test(
        'setDeclarationEntity',
        () {
          const String selectedStatus = "REMOTE";

          when(declarationRepository.setAllDayDeclaration(selectedStatus));
          expect(
            declarationRepository.statusAllDay,
            selectedStatus,
          );
        },
      );
    },
  );
  group('Declaration halfDay respository create()', () {
    final DeclarationModel declarationMorning = DeclarationModel(
      declarationDate: DateTime.utc(2023, 4, 17),
      declarationDateStart: DateTime.utc(2023, 4, 17, 00),
      declarationDateEnd: DateTime.utc(2023, 4, 17, 12),
      declarationTeamMateId: 123,
      declarationStatus: 'remote',
    );
    final DeclarationModel declarationAfternoon = DeclarationModel(
      declarationDate: DateTime.utc(2023, 4, 17),
      declarationDateStart: DateTime.utc(2023, 4, 17, 13),
      declarationDateEnd: DateTime.utc(2023, 4, 17, 23),
      declarationTeamMateId: 123,
      declarationStatus: 'other',
    );
    final List<DeclarationModel> declarations = [
      declarationMorning,
      declarationAfternoon
    ];
    test(
      'should set declaration status after creating declarations',
      () async {
        // Mock the API's create method to return the response defined above
        when(mockedDeclarationApi.create(declarations, 'halfDay'))
            .thenAnswer((realInvocation) => Future.value(httpResponse));
        when(httpResponse.response).thenReturn(response);
        when(response.statusCode).thenReturn(200 | 201);
        when(httpResponse.data).thenReturn(createResponseApi);
        declarationRepository.declarationStatus.morningDeclaration = "remote";
        declarationRepository.declarationStatus.afternoonDeclaration = "other";
        await declarationRepository.createHalfDay(declarations);
        expect(
          declarationRepository.declarationStatus.morningDeclaration,
          "remote",
        );
        expect(
          declarationRepository.declarationStatus.afternoonDeclaration,
          "other",
        );
      },
    );
    test('Fail create declaration 400 or 500.', () async {
      when(mockedDeclarationApi.create(declarations, 'halfDay'))
          .thenAnswer((realInvocation) => Future.value(httpResponse));
      when(httpResponse.response).thenReturn(response);
      when(response.statusCode).thenReturn(400 | 500);
      when(httpResponse.data).thenReturn(createResponseApi);
      declarationRepository.declarationStatus.morningDeclaration = "";
      declarationRepository.declarationStatus.afternoonDeclaration = "";
      await declarationRepository.createHalfDay(declarations);
      expect(
        declarationRepository.declarationStatus.morningDeclaration,
        "",
      );
      expect(
        declarationRepository.declarationStatus.afternoonDeclaration,
        "",
      );
    });
    test('Fail create declaration 401.', () async {
      when(mockedDeclarationApi.create(declarations, 'halfDay'))
          .thenAnswer((realInvocation) => Future.value(httpResponse));
      when(httpResponse.response).thenReturn(response);
      when(response.statusCode).thenReturn(401);
      when(httpResponse.data).thenReturn(createResponseApi);
      declarationRepository.declarationStatus.morningDeclaration = "";
      declarationRepository.declarationStatus.afternoonDeclaration = "";
      await declarationRepository.createHalfDay(declarations);
      expect(
        declarationRepository.declarationStatus.morningDeclaration,
        "",
      );
      expect(
        declarationRepository.declarationStatus.afternoonDeclaration,
        "",
      );
    });
    test('Fail create declaration 403.', () async {
      when(mockedDeclarationApi.create(declarations, 'halfDay'))
          .thenAnswer((realInvocation) => Future.value(httpResponse));
      when(httpResponse.response).thenReturn(response);
      when(response.statusCode).thenReturn(403);
      when(httpResponse.data).thenReturn(createResponseApi);
      declarationRepository.declarationStatus.morningDeclaration = "";
      declarationRepository.declarationStatus.afternoonDeclaration = "";
      await declarationRepository.createHalfDay(declarations);
      expect(
        declarationRepository.declarationStatus.morningDeclaration,
        "",
      );
      expect(
        declarationRepository.declarationStatus.afternoonDeclaration,
        "",
      );
    });
  });
  group(
    'Assign status, to declarationStatus entities.',
    () {
      test(
        'set half day Declaration',
        () {
          const String selectedStatusMorning = "remote";
          const String selectedStatusAfternoon = "other";
          when(
            declarationRepository.setHalfDayDeclaration(
              selectedStatusMorning,
              selectedStatusAfternoon,
            ),
          );
          expect(
            declarationRepository.declarationStatus.morningDeclaration,
            selectedStatusMorning,
          );
          expect(
            declarationRepository.declarationStatus.afternoonDeclaration,
            selectedStatusAfternoon,
          );
        },
      );
    },
  );
}
