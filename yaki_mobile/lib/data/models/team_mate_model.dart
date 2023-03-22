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
  @JsonKey(name: 'team_mate_id')
  int teamMateId;
  @JsonKey(name: 'declaration_date')
  DateTime? declarationDate;
  @JsonKey(name: 'declaration_status')
  String? declarationStatus;

  TeamMateModel({
    required this.userId,
    required this.userLastName,
    required this.userFirstName,
    required this.teamMateId,
    required this.declarationDate,
    required this.declarationStatus,
  });

  factory TeamMateModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
}
