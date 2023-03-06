import 'package:json_annotation/json_annotation.dart';

part 'team_mate_model.g.dart';

// @JsonSerializable()
// class TeamMateModel {
//   int userId;
//   String userLastName;
//   String userFirstName;
//   String userEmail;
//   String userLogin;
//   String userPassword;
//   int teamMateId;
//   int teamMateTeamId;
//   int teamMateUserId;
//
//   TeamMateModel({
//     required this.userId,
//     required this.userLastName,
//     required this.userFirstName,
//     required this.userEmail,
//     required this.userLogin,
//     required this.userPassword,
//     required this.teamMateId,
//     required this.teamMateTeamId,
//     required this.teamMateUserId,
//   });
//
//   factory TeamMateModel.fromJson(Map<String, dynamic> json) =>
//       _$TeamMateModelFromJson(json);
//   Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
// }
@JsonSerializable()
class TeamMateModel {
  int user_id;
  String user_last_name;
  String user_first_name;
  String user_email;
  int team_mate_id;
  int team_mate_team_id;
  int team_mate_user_id;
  DateTime declaration_date;
  String declaration_status;

  TeamMateModel({
    required this.user_id,
    required this.user_last_name,
    required this.user_first_name,
    required this.user_email,
    required this.team_mate_id,
    required this.team_mate_team_id,
    required this.team_mate_user_id,
    required this.declaration_date,
    required this.declaration_status,
  });

  factory TeamMateModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
}
