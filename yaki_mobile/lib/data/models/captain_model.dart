
import 'package:json_annotation/json_annotation.dart';
part 'captain_model.g.dart';

@JsonSerializable()
class CaptainModel {
  int team_mate_id;
  int team_mate_team_id;
  int team_mate_user_id;
  int user_id;
  String user_last_name;
  String user_first_name;
  String user_mail;
  String user_login;
  String user_password;

  CaptainModel({
    required this.team_mate_id,
    required this.team_mate_team_id,
    required this.team_mate_user_id,
    required this.user_id,
    required this.user_last_name,
    required this.user_first_name,
    required this.user_mail,
    required this.user_login,
    required this.user_password,
  });

  factory CaptainModel.fromJson(Map<String, dynamic> json) => _$CaptainModelFromJson(json);
  Map<String, dynamic> toJson() => _$CaptainModelToJson(this);
}