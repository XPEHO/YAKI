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
  final httpResponseGet = MockHttpResponse();
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
    }
  ];

  final Map<String, dynamic> createResponseApiGet = {
    "declarationId": 2,
    "declarationDate": DateTime.now().toIso8601String(),
    "declarationDateStart": DateTime.now().toIso8601String(),
    "declarationDateEnd": DateTime.now().toIso8601String(),
    "declarationTeamMateId": 3,
    "declarationStatus": "REMOTE"
  };

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
            (realInvocation) => Future.value(httpResponseGet),
          );
          when(httpResponseGet.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponseGet.data).thenReturn(createResponseApiGet);

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
    'Declaration respository create()',
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
          expect(declarationRepository.statusAllDay, selectedStatus);
        },
      );
    },
  );
}
