import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yaki/data/models/declaration_model.dart';

void main() {

  Map<String, dynamic> declarationModelAsJson = {
    "declarationDate": '2023-03-20T10:00:00.950Z',
    "declarationTeamMateId": 3,
    "declarationStatus": 'VACATION',
  };

  DeclarationModel declarationModel = DeclarationModel(
      declarationDate: DateTime.parse('2023-03-20T10:00:00.950Z'),
      declarationTeamMateId: 3,
      declarationStatus: 'VACATION',
  );


  group(
    'DeclarationModel from & toJson',
    () {
      test(
        'declarationModel fromJson',
        () {
          DeclarationModel declarationFromJson = DeclarationModel.fromJson(declarationModelAsJson);
          expect(declarationFromJson.toJson().toString() == declarationModel.toJson().toString(), true);
        },
      );
      test(
        'declarationModel ToJson',
        () {
          Map<String, dynamic> declarationModelToJson = declarationModel.toJson();
          expect(mapEquals(declarationModelToJson, declarationModelAsJson), true);
        },
      );
    },
  );
}
