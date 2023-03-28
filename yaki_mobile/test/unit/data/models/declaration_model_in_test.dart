import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/declaration_model_in.dart';

void main() {
  Map<String, dynamic> declarationInAsJson = {
    "declarationId": 83,
    "declarationTeamMateId": 15,
    "declarationDate": "2023-03-20T10:00:00.950Z",
    "declarationStatus": "REMOTE"
  };

  DeclarationModelIn declarationModelIn = DeclarationModelIn(
    declarationId: 83,
    declarationTeamMateId: 15,
    declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
    declarationStatus: "REMOTE",
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

          expect(
            mapEquals(declarationInToJson, declarationInAsJson),
            true,
          );
        },
      );
    },
  );
}
