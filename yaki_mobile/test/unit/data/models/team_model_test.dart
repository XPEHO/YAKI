import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/data/models/team_model.dart';

void main() {
  Map<String, dynamic> teamModelAsJson = {
    "teamId": 1,
    "teamName": "Team 1",
    "teamActifFlag": true,
  };

  TeamModel teamModel = TeamModel(
    teamId: 1,
    teamName: "Team 1",
    teamActifFlag: true,
  );

  group(
    'TeamModel, from & ToJson test',
    () {
      test(
        'TeamModel fromJson',
        () {
          TeamModel teamModelFromJson = TeamModel.fromJson(teamModelAsJson);

          expect(
            teamModelFromJson.toJson().toString() ==
                teamModel.toJson().toString(),
            true,
          );
        },
      );
      test(
        'TeamModel toJson',
        () {
          Map<String, dynamic> teamModelToJson = teamModel.toJson();
          // compare Map / Json
          expect(
            mapEquals(teamModelToJson, teamModelAsJson),
            true,
          );
        },
      );
    },
  );

  group('hasCode and operator', () {
    test('hashCode', () {
      expect(teamModel.hashCode, isNotNull);
    });

    test('== operator', () {
      final TeamModel teamModelOperator = TeamModel(
        teamId: 1,
        teamName: "Team 1",
        teamActifFlag: true,
      );

      expect(teamModelOperator == teamModel, true);
    });

    test('!= operator', () {
      final TeamModel teamModelOperator = TeamModel(
        teamId: 1,
        teamName: "Team 2",
        teamActifFlag: true,
      );

      expect(teamModelOperator == teamModel, false);
    });
  });
}
