import 'package:json_annotation/json_annotation.dart';

part 'team_mate_model.g.dart';

@JsonSerializable()
class TeamMateModel {
  int teamMateId;
  int userId;
  int teamId;
  String lastName;
  String firstName;
  String email;
  String? token;


  TeamMateModel({
    required this.teamMateId,
    required this.userId,
    required this.teamId,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.token,
  });

  factory TeamMateModel.fromJson(Map<String, dynamic> json) => _$TeamMateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
}
