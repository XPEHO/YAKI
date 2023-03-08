import 'package:json_annotation/json_annotation.dart';

part 'team_mate_model.g.dart';

@JsonSerializable()
class TeamMateModel {
  int team_mate_id;
  int team_mate_team_id;
  int team_mate_user_id;
  int user_id;
  String user_last_name;
  String user_first_name;
  String user_email;
  String user_login;
  String user_password;

  TeamMateModel({
    required this.team_mate_id,
    required this.team_mate_team_id,
    required this.team_mate_user_id,
    required this.user_id,
    required this.user_last_name,
    required this.user_first_name,
    required this.user_email,
    required this.user_login,
    required this.user_password,
  });

  factory TeamMateModel.fromJson(Map<String, dynamic> json) => _$TeamMateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
}
