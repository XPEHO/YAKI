import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable()
class TeamModel {
  @JsonKey(name: 'team_id')
  int? teamId;
  @JsonKey(name: 'team_captain_id')
  int? teamCaptainId;
  @JsonKey(name: 'team_name')
  String? teamName;

  TeamModel({
    required this.teamId,
    required this.teamCaptainId,
    required this.teamName,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamModelToJson(this);
}
