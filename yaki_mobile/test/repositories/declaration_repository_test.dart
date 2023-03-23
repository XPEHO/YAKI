import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';

import 'declaration_repository_test.mocks.dart';

@GenerateMocks(
  [
    DeclarationApi,
    Response,
  ],
  customMocks: [
    MockSpec<HttpResponse<Map<String, dynamic>>>(
      as: #MockHttpResponse,
    ),
    MockSpec<HttpResponse<List<Map<String, dynamic>>>>(
      as: #MockHttpResponseList,
    ),
    MockSpec<HttpResponse<String>>(
      as: #MockHttpResponseString,
    ),
  ],
)
void main() {

  final mockedApi = MockDeclarationApi();
  final httpResponse = MockHttpResponse();
  final response = MockResponse();
  final declarationRepository = DeclarationRepository(mockedApi);

  const String teammateId = "1";

  final Map<String, dynamic> responseApi = {
    "declarationId": 2,
    "declarationDate": DateTime.now().toIso8601String(),
    "declarationTeamMateId": 3,
    "declarationStatus": "Remote"
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

          expect(status, "Remote");
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
          when(response.statusCode).thenReturn(500);
          when(httpResponse.data).thenReturn(errorResponse);

          final String status =
          await declarationRepository.getDeclaration(teammateId);

          expect(status, "");
        },
      );
    },
  );
  group('Declaration respository create()', () {

  });
}
