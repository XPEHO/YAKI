import 'package:json_annotation/json_annotation.dart';

part 'team_mate_model.g.dart';

@JsonSerializable()
class TeamMateModel {
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'user_last_name')
  String userLastName;
  @JsonKey(name: 'user_first_name')
  String userFirstName;
  @JsonKey(name: 'user_email')
  String userEmail;
  @JsonKey(name: 'user_login')
  String userLogin;
  @JsonKey(name: 'user_password')
  String userPassword;
  @JsonKey(name: 'team_mate_id')
  int teamMateId;
  @JsonKey(name: 'team_mate_team_id')
  int teamMateTeamId;
  @JsonKey(name: 'team_mate_user_id')
  int teamMateUserId;
  @JsonKey(name: 'declaration_date')
  DateTime declarationDate;
  @JsonKey(name: 'declaration_team_mate_id')
  int declarationTeamMateId;
  @JsonKey(name: 'declaration_id')
  int declarationId;
  @JsonKey(name: 'declaration_status')
  String declarationStatus;

  TeamMateModel({
    required this.userId,
    required this.userLastName,
    required this.userFirstName,
    required this.userEmail,
    required this.userLogin,
    required this.userPassword,
    required this.teamMateId,
    required this.teamMateTeamId,
    required this.teamMateUserId,
    required this.declarationDate,
    required this.declarationTeamMateId,
    required this.declarationId,
    required this.declarationStatus,
  });

  factory TeamMateModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
}
