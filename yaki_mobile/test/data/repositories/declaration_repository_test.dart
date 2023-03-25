import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';

import '../../mocking.mocks.dart';
import 'declaration_repository_test.mocks.dart';

@GenerateMocks(
  [
    DeclarationApi,
  ],
)
void main() {
  final httpResponse = MockHttpResponse();
  final response = MockResponse();

  final mockedApi = MockDeclarationApi();
  final declarationRepository = DeclarationRepository(mockedApi);

  const String selectedStatus = "REMOTE";

  DeclarationModel createdDeclaration = DeclarationModel(
    declarationDate: DateTime.now(),
    declarationTeamMateId: 1,
    declarationStatus: "REMOTE",
  );

  const String teammateId = "1";

  final Map<String, dynamic> responseApi = {
    "declarationId": 2,
    "declarationDate": DateTime.now().toIso8601String(),
    "declarationTeamMateId": 3,
    "declarationStatus": "REMOTE"
  };

  final Map<String, dynamic> errorResponse = {};

  group(
    'declaration repository getDeclaration()',
    () {
      test(
        'Successfully GET daily declaration.',
        () async {
          // Stubbing
          when(mockedApi.getDeclaration(teammateId))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponse.data).thenReturn(responseApi);

          final String status =
              await declarationRepository.getDeclaration(teammateId);

          expect(status, "REMOTE");
        },
      );
      test(
        'Fail to get the last declaration, or no daily declaration.',
        () async {
          // Stubbing
          when(mockedApi.getDeclaration(teammateId))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(404);
          when(httpResponse.data).thenReturn(errorResponse);

          final String status =
              await declarationRepository.getDeclaration(teammateId);

          expect(status, "");
        },
      );
      test(
        'throw exception when get declaration',
        () async {
          // Stubbing
          when(mockedApi.getDeclaration(teammateId))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(418);
          when(httpResponse.data).thenReturn(errorResponse);

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
      test(
        'Successfully create declaration.',
        () async {
          when(mockedApi.create(createdDeclaration))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200 | 201);
          when(httpResponse.data).thenReturn(responseApi);

          await declarationRepository.create(createdDeclaration);

          expect(declarationRepository.status, "REMOTE");
        },
      );
      test(
        'Fail create declaration 400 or 500.',
        () async {
          when(mockedApi.create(createdDeclaration))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(400 | 500);
          when(httpResponse.data).thenReturn(responseApi);

          await declarationRepository.create(createdDeclaration);

          expect(declarationRepository.status, "");
        },
      );
      test(
        'Fail create declaration 401.',
        () async {
          when(mockedApi.create(createdDeclaration))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(401);
          when(httpResponse.data).thenReturn(responseApi);

          await declarationRepository.create(createdDeclaration);

          expect(declarationRepository.status, "");
        },
      );
      test(
        'Fail create declaration 403.',
        () async {
          when(mockedApi.create(createdDeclaration))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(403);
          when(httpResponse.data).thenReturn(responseApi);

          await declarationRepository.create(createdDeclaration);

          expect(declarationRepository.status, "");
        },
      );
      test(
        'Throw exception when create declaration',
        () async {
          when(mockedApi.create(createdDeclaration))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(418);
          when(httpResponse.data).thenReturn(responseApi);

          await declarationRepository.create(createdDeclaration);

          expect(declarationRepository.status, "");
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
          when(declarationRepository.setDeclarationEntities(selectedStatus));

          expect(declarationRepository.status, selectedStatus);
        },
      );
    },
  );
}
