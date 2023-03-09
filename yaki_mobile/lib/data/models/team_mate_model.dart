import 'package:json_annotation/json_annotation.dart';

part 'team_mate_model.g.dart';

@JsonSerializable()
class TeamMateModel {
  int team_mate_id;
  int user_id;
  int team_id;
  String last_name;
  String first_name;
  String email;
  String token;


  TeamMateModel({
    required this.team_mate_id,
    required this.user_id,
    required this.team_id,
    required this.last_name,
    required this.first_name,
    required this.email,
    required this.token,
  });

  factory TeamMateModel.fromJson(Map<String, dynamic> json) => _$TeamMateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
}
