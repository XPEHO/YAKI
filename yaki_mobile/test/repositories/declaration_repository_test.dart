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
  group(
    'declaration repository',
    () {
      final mockedApi = MockDeclarationApi();
      final httpResponse = MockHttpResponse();
      final response = MockResponse();
      final declarationRepository = DeclarationRepository(mockedApi);

      const String teammateId = "1";

      test(
        'successfully get the last daily declaration',
        () async {
          final Map<String, dynamic> responseApi = {
            "declarationId": 2,
            "declarationDate": DateTime.now().toIso8601String(),
            "declarationTeamMateId": 3,
            "declarationStatus": "Remote"
          };

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
      test('fail to get the last declaration, or no daily declaration',
          () async {
        final Map<String, dynamic> errorResponse = {};

        when(mockedApi.getDeclaration(teammateId))
            .thenAnswer((realInvocation) => Future.value(httpResponse));
        when(httpResponse.response).thenReturn(response);
        when(response.statusCode).thenReturn(404);
        when(httpResponse.data).thenReturn(errorResponse);

        final String status =
            await declarationRepository.getDeclaration(teammateId);

        expect(status, "");
      });
    },
  );
}
