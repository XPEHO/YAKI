import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/declaration_model_in.dart';

void main() {
  // simulate json send by API
  Map<String, dynamic> declarationInAsJson = {
    "declarationId": 83,
    "declarationDate": "2023-03-20T10:00:00.950Z",
    "declarationDateStart": "2023-03-20T00:00:00.950Z",
    "declarationDateEnd": "2023-03-20T23:59:59.950Z",
    "declarationTeamMateId": 15,
    "declarationStatus": "REMOTE",
    "declarationTeamId": 2,
  };

  // model instance once json is parsed into dart usable model
  DeclarationModelIn declarationModelIn = DeclarationModelIn(
    declarationId: 83,
    declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
    declarationDateStart: DateTime.parse('2023-03-20T00:00:00.950Z'),
    declarationDateEnd: DateTime.parse('2023-03-20T23:59:59.950Z'),
    declarationTeamMateId: 15,
    declarationStatus: "REMOTE",
    declarationTeamId: 2,
  );

  group(
    'Declaration In, from & ToJson test',
    () {
      test(
        'declaration in fromJson',
        () {
          DeclarationModelIn declarationInFromJson =
              DeclarationModelIn.fromJson(declarationInAsJson);

          expect(
            declarationInFromJson.toJson().toString() ==
                declarationModelIn.toJson().toString(),
            true,
          );
        },
      );
      test(
        'declaration in toJson',
        () {
          Map<String, dynamic> declarationInToJson =
              declarationModelIn.toJson();

          // compare Map / Json
          expect(
            mapEquals(declarationInToJson, declarationInAsJson),
            true,
          );
        },
      );
    },
  );
}
