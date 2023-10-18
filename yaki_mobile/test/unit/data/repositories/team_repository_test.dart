import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/data/sources/remote/team_api.dart';
import '../../mocking.mocks.dart';
import './team_repository_test.mocks.dart';

@GenerateMocks([
  TeamApi,
])
void main() {
  const userId = 42;
  SharedPreferences.setMockInitialValues(
    {
      'token': '',
      'userId': userId,
    },
  );
  final teamApi = MockTeamApi();
  final teamRepository = TeamRepository(
    teamApi,
  );
  test('getTeam', () async {
    // GIVEN

    // Mock HttpResponse
    final httpResponse = MockHttpResponseList();

    // Mock Response
    final response = MockResponse();
    when(response.statusCode).thenReturn(200);
    when(httpResponse.response).thenReturn(response);

    // Mock data
    final data = <Map<String, dynamic>>[
      {
        'teamId': 1,
        'teamName': 'teamName',
        "teamActifFlag": true,
      },
    ];
    when(httpResponse.data).thenReturn(data);

    when(teamApi.getTeam(userId)).thenAnswer(
      (realInvocation) => Future.value(
        httpResponse,
      ),
    );

    // WHEN
    final teamList = await teamRepository.getTeam();

    // THEN
    expect(teamList.length, 1);
    expect(teamList[0].teamId, 1);
    expect(teamList[0].teamName, 'teamName');
  });
}
