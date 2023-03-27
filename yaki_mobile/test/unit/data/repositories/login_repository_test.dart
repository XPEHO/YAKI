import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/models/login_model.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/data/sources/remote/login_api.dart';

import '../../mocking.mocks.dart';
import 'login_repository_test.mocks.dart';

@GenerateMocks(
  [
    LoginApi,
  ],
)
void main() {
  final httpResponse = MockHttpResponse();
  final response = MockResponse();

  final mockedLoginApi = MockLoginApi();
  final loginRepository = LoginRepository(mockedLoginApi);

  String teammateLog = "dupond";
  String teammatePw = "dupond";

  String captainLog = "lavigne";
  String captainPw = "lavigne";

  LoginModel teammateLogin = LoginModel(login: teammateLog, password: teammatePw);
  LoginModel captainLogin = LoginModel(login: captainLog, password: captainPw);

  final Map<String, dynamic> authenticationDupond = {
    "token": "azertyuioptoken",
    "teamMateId": 7,
    "userId": 3,
    "teamId": 2,
    "lastName": "Dupond",
    "firstName": "Dupond",
    "email": "dupond@mail.com"
  };

  final Map<String, dynamic> authenticationLavigne = {
    "token": "azertyuioptoken",
    "captainId": 1,
    "userId": 6,
    "lastName": "Lavigne",
    "firstName": "Lavigne",
    "email": "lavigne@mail.com"
  };

  final Map<String, dynamic> authenticationFail = {};

  group(
    'authentication methode',
    () {
      test(
        'Successfully authenticate as teammate',
        () async {
          when(mockedLoginApi.postLogin(teammateLogin)).thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponse.data).thenReturn(authenticationDupond);

          final bool isCaptain = await loginRepository.userAuthentication("dupond", "dupond");


           //expect(isCaptain, false);
        },
      );
    },
  );
}
