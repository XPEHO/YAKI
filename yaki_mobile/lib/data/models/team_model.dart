import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable()
class TeamModel {
  int? teamId;
  int? teamCaptainId;
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
