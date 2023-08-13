import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/declaration_model.dart';

void main() {
  // simulate json send by API
  Map<String, dynamic> declarationModelAsJson = {
    "declarationUserId": 1,
    "declarationDate": '2023-03-20T10:00:00.950Z',
    "declarationDateStart": '2023-03-20T00:00:00.000Z',
    "declarationDateEnd": '2023-03-20T23:59:59.950Z',
    "declarationStatus": 'VACATION',
    "declarationTeamId": 2,
  };
  // model instance once json is parsed into dart usable model
  DeclarationModel declarationModel = DeclarationModel(
    declarationUserId: 1,
    declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
    declarationDateStart: DateTime.parse('2023-03-20T00:00:00.000Z'),
    declarationDateEnd: DateTime.parse('2023-03-20T23:59:59.950Z'),
    declarationStatus: 'VACATION',
    declarationTeamId: 2,
  );

  group(
    'DeclarationModel from & toJson',
    () {
      test(
        'declarationModel fromJson',
        () {
          DeclarationModel declarationFromJson =
              DeclarationModel.fromJson(declarationModelAsJson);
          expect(
            declarationFromJson.toJson().toString() ==
                declarationModel.toJson().toString(),
            true,
          );
        },
      );
      test(
        'declarationModel ToJson',
        () {
          Map<String, dynamic> declarationModelToJson =
              declarationModel.toJson();
          // compare Map / Json
          expect(
            mapEquals(declarationModelToJson, declarationModelAsJson),
            true,
          );
        },
      );
    },
  );
}
