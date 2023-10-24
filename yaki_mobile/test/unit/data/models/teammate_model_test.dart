import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/teammate_with_declaration_model.dart';

void main() {
  // simulate json send by API
  Map<String, dynamic> teammateModelAsJson = {
    "userId": 1,
    "userLastName": "dupond",
    "userFirstName": "dupond",
    "declarationDate": "2023-03-20T10:00:00.950Z",
    "declarationDateStart": "2023-03-20T10:00:00.950Z",
    "declarationDateEnd": "2023-03-20T10:00:00.950Z",
    "declarationStatus": "Testing",
    "teamId": 1,
    "teamName": "Team 1",
    "customerId": 1,
    "customerName": "customerName",
  };
  // model instance once json is parsed into dart usable model
  TeammateWithDeclarationModel teammateModel = TeammateWithDeclarationModel(
    userId: 1,
    userLastName: "dupond",
    userFirstName: "dupond",
    declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
    declarationDateStart: DateTime.parse('2023-03-20T10:00:00.950Z'),
    declarationDateEnd: DateTime.parse('2023-03-20T10:00:00.950Z'),
    declarationStatus: "Testing",
    teamId: 1,
    teamName: "Team 1",
    customerId: 1,
    customerName: "customerName",
  );

  group(
    'TeamMateModel, from & ToJson test',
    () {
      test(
        'TeamMateModel fromJson',
        () {
          TeammateWithDeclarationModel teammateModelFromJson =
              TeammateWithDeclarationModel.fromJson(teammateModelAsJson);

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
          // compare Map / Json
          expect(
            mapEquals(teammateModelToJson, teammateModelAsJson),
            true,
          );
        },
      );
    },
  );
}
