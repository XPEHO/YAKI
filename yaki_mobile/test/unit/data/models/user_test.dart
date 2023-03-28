import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/user.dart';


void main() {
  Map<String, dynamic> userAsJson = {
    "token": "azertyuioptoken",
    "captainId": 1,
    "teamMateId": null,
    "teamId": null,
    "userId": 15,
    "lastName": "dupond",
    "firstName": "dupond",
    "email": "dupond@gmail.com"
  };

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
          User userFromJson =
          User.fromJson(userAsJson);

          expect(
            userFromJson.toJson().toString() ==
                user.toJson().toString(),
            true,
          );
        },
      );
      test(
        'User toJson',
            () {
          Map<String, dynamic> userToJson =
          user.toJson();

          expect(
            mapEquals(userToJson, userAsJson),
            true,
          );
        },
      );
    },
  );
}
