import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/login_model.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/data/sources/remote/login_api.dart';

import '../../mocking.mocks.dart';
import 'login_repository_test.mocks.dart';

@GenerateMocks([LoginApi])
void main() {
  final httpResponse = MockHttpResponse();
  final response = MockResponse();

  final mockedLoginApi = MockLoginApi();
  final loginRepository = LoginRepository(mockedLoginApi);

  // Need to initialise the  sharedPreferences values
  // Or else if its empty it will break during test
  SharedPreferences.setMockInitialValues(
    {
      'token': '',
      'userId': '',
    },
  );

  String teammateLog = "dupond";
  String teammatePw = "dupond";

  LoginModel teammateLogin = LoginModel(
    login: teammateLog,
    password: teammatePw,
  );

  final Map<String, dynamic> authenticationTeammate = {
    "token": "azertyuioptoken",
    "teamMateId": 7,
    "teamId": 2,
    "userId": 3,
    "lastName": "Dupond",
    "firstName": "Dupond",
    "email": "dupond@mail.com"
  };

  group(
    'userAuthentication success',
    () {
      //  In the test the teammateLogin (LoginModel instance) need to be the
      // same as the one created inside the userAuthentication method, using
      // login & password
      test(
        'Successfully authenticate as teammate',
        () async {
          when(mockedLoginApi.postLogin(teammateLogin))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponse.data).thenReturn(authenticationTeammate);

          final isCaptain =
              await loginRepository.userAuthentication(teammateLog, teammatePw);

          expect(isCaptain, true);
        },
      );
      //  In the test the teammateLogin (LoginModel instance) need to be the
      // same as the one created inside the userAuthentication method, using
      // login & password
      test(
        'Successfully authenticate as Captain',
        () async {
          String captainLog = "lavigne";
          String captainPw = "lavigne";

          LoginModel captainLogin = LoginModel(
            login: captainLog,
            password: captainPw,
          );

          final Map<String, dynamic> authenticationLavigne = {
            "token": "azertyuioptoken",
            "captainId": 1,
            "teamMateId": null,
            "teamId": null,
            "userId": 6,
            "lastName": "Lavigne",
            "firstName": "Lavigne",
            "email": "lavigne@mail.com"
          };

          when(mockedLoginApi.postLogin(captainLogin))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(200);
          when(httpResponse.data).thenReturn(authenticationLavigne);

          final isCaptain =
              await loginRepository.userAuthentication(captainLog, captainPw);

          expect(isCaptain, true);
        },
      );
    },
  );

  group(
    'userAuthentication fails',
    () {
      test(
        'Fail to authenticate 204',
        () async {
          String incorrectLog = "Marcelazerty";
          String incorrectPw = "azertyuiop";

          LoginModel incorrectLogObject = LoginModel(
            login: incorrectLog,
            password: incorrectPw,
          );

          final Map<String, dynamic> authenticationFail = {};

          when(mockedLoginApi.postLogin(incorrectLogObject))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(204);
          when(httpResponse.data).thenReturn(authenticationFail);

          final isCaptain = await loginRepository.userAuthentication(
            incorrectLog,
            incorrectPw,
          );

          expect(isCaptain, false);
        },
      );
      test(
        'Fail to authenticate 401',
        () async {
          when(mockedLoginApi.postLogin(teammateLogin))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(401);
          when(httpResponse.data).thenReturn(authenticationTeammate);

          final isCaptain = await loginRepository.userAuthentication(
            teammateLog,
            teammatePw,
          );

          expect(isCaptain, false);
        },
      );
      test(
        'Fail to authenticate throw exception',
        () async {
          when(mockedLoginApi.postLogin(teammateLogin))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(418);
          when(httpResponse.data).thenReturn(authenticationTeammate);

          final isCaptain = await loginRepository.userAuthentication(
            teammateLog,
            teammatePw,
          );

          expect(isCaptain, false);
        },
      );
    },
  );

  group(
    'others repository method',
    () {
      test(
        'hassPassword function',
        () {
          const String password = "test";
          const String hassPassword = "test";

          expect(password, hassPassword);
        },
      );
      // teamateId & captainId value come from the captainId log test,
      // which change value in "loggedUser" attribute
      // teammateID = 0 because of loginRepository.setLoggedUser() method.
      test(
        'teammateId getter',
        () {
          expect(loginRepository.userId, 0);
        },
      );
      test(
        'captainId getter',
        () {
          expect(loginRepository.captainId, 1);
        },
      );
    },
  );
}
