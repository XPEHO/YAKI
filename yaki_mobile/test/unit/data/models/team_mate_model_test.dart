import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/team_mate_model.dart';

void main() {
  Map<String, dynamic> teammateModelAsJson = {
    "userId": 1,
    "userLastName": "dupond",
    "userFirstName": "dupond",
    "teamMateId": 1,
    "declarationDate": "2023-03-20T10:00:00.950Z",
    "declarationStatus": "Testing",
  };

  TeamMateModel teammateModel = TeamMateModel(
    userId: 1,
    userLastName: "dupond",
    userFirstName: "dupond",
    teamMateId: 1,
    declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
    declarationStatus: "Testing",
  );

  group(
    'TeamMateModel, from & ToJson test',
    () {
      test(
        'TeamMateModel fromJson',
        () {
          TeamMateModel teammateModelFromJson =
              TeamMateModel.fromJson(teammateModelAsJson);

          expect(
            teammateModelFromJson.toJson().toString() ==
                teammateModel.toJson().toString(),
            true,
          );
        },
      );
      test(
        'TeamMateModel toJson',
        () {
          Map<String, dynamic> teammateModelToJson = teammateModel.toJson();

          expect(
            mapEquals(teammateModelToJson, teammateModelAsJson),
            true,
          );
        },
      );
    },
  );
}
