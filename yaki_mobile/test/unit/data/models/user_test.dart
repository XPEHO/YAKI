import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/user.dart';

void main() {
  // simulate json send by API
  Map<String, dynamic> userAsJson = {
    "token": "azertyuioptoken",
    "captainId": 1,
    "teamMateId": null,
    "teamId": null,
    "userId": 15,
    "lastName": "dupond",
    "firstName": "dupond",
    "email": "dupond@gmail.com",
  };
  // model instance once json is parsed into dart usable model
  User user = User(
    token: "azertyuioptoken",
    captainId: 1,
    teamMateId: null,
    teamId: null,
    userId: 15,
    lastName: "dupond",
    firstName: "dupond",
    email: "dupond@gmail.com",
  );

  group(
    'User, from & ToJson test',
    () {
      test(
        'User fromJson',
        () {
          User userFromJson = User.fromJson(userAsJson);

          expect(
            userFromJson.toJson().toString() == user.toJson().toString(),
            true,
          );
        },
      );
      test(
        'User toJson',
        () {
          Map<String, dynamic> userToJson = user.toJson();

          // compare Map / Json
          expect(
            mapEquals(userToJson, userAsJson),
            true,
          );
        },
      );
    },
  );
}
