import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/login_model.dart';

void main() {
  Map<String, dynamic> loginModelAsJson = {
    "login": "dupond",
    "password": "dupond"
  };

  LoginModel loginModel = LoginModel(
    login: "dupond",
    password: "dupond",
  );

  group(
    'Login model, from & ToJson test',
    () {
      test(
        'Login model fromJson',
        () {
          LoginModel loginModelFromJson = LoginModel.fromJson(loginModelAsJson);

          expect(
            loginModel == loginModelFromJson,
            true,
          );
        },
      );
      test(
        'Login model toJson',
        () {
          Map<String, dynamic> loginModelToJson = loginModel.toJson();

          expect(
            mapEquals(loginModelToJson, loginModelAsJson),
            true,
          );
        },
      );
    },
  );
}
