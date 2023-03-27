import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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

  String teammateLog = "dupond";
  String teammatePw = "dupond";
  LoginModel teammateLogin = LoginModel(
    login: teammateLog,
    password: teammatePw,
  );

  final Map<String, dynamic> authenticationDupond = {
    "token": "azertyuioptoken",
    "teamMateId": 7,
    "teamId": 2,
    "userId": 3,
    "lastName": "Dupond",
    "firstName": "Dupond",
    "email": "dupond@mail.com"
  };

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

  String incorrectLog = "Marcelazerty";
  String incorrectPw = "azertyuiop";
  LoginModel incorrectLogObject = LoginModel(
    login: incorrectLog,
    password: incorrectPw,
  );
  final Map<String, dynamic> authenticationFail = {};

  group(
    'authentication methode',
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
          when(httpResponse.data).thenReturn(authenticationDupond);

          final isCaptain =
              await loginRepository.userAuthentication(teammateLog, teammatePw);

          expect(isCaptain, isFalse);
        },
      );
      //  In the test the teammateLogin (LoginModel instance) need to be the
      // same as the one created inside the userAuthentication method, using
      // login & password
      test(
        'Successfully authenticate as Captain',
            () async {
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
      test(
        'Fail to authenticate 204',
            () async {
          when(mockedLoginApi.postLogin(captainLogin))
              .thenAnswer((realInvocation) => Future.value(httpResponse));
          when(httpResponse.response).thenReturn(response);
          when(response.statusCode).thenReturn(204);
          when(httpResponse.data).thenReturn(authenticationLavigne);

          final isCaptain =
          await loginRepository.userAuthentication(teammateLog, "azertyuiop");

          expect(isCaptain, false);
        },
      );
    },
  );

  group(
    'others repo method',
    () {
      test(
        'invoke function to save into sharedPreference',
        () {},
      );
    },
  );
}
