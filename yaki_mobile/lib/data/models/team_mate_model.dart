import 'package:json_annotation/json_annotation.dart';

part 'team_mate_model.g.dart';

@JsonSerializable()
class TeamMateModel {
  int userId;
  String userLastName;
  String userFirstName;
  String userEmail;
  int teamMateId;
  int teamMateTeamId;
  int teamMateUserId;
  DateTime declarationDate;
  String declarationStatus;

  TeamMateModel({
    required this.userId,
    required this.userLastName,
    required this.userFirstName,
    required this.userEmail,
    required this.teamMateId,
    required this.teamMateTeamId,
    required this.teamMateUserId,
    required this.declarationDate,
    required this.declarationStatus,
  });

  factory TeamMateModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
}
