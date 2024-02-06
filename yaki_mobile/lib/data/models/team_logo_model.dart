import 'package:json_annotation/json_annotation.dart';

part 'team_logo_model.g.dart';

@JsonSerializable()
class TeamLogoModel {
  int teamLogoTeamId;
  TeamLogoBlob teamLogoBlob;

  TeamLogoModel({
    required this.teamLogoTeamId,
    required this.teamLogoBlob,
  });

  factory TeamLogoModel.fromJson(Map<String, dynamic> json) =>
      _$TeamLogoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamLogoModelToJson(this);

  @override
  String toString() {
    return 'TeamLogoModel{teamLogoTeamId: $teamLogoTeamId, teamLogoBlob: $teamLogoBlob}';
  }
}

@JsonSerializable()
class TeamLogoBlob {
  String type;
  List<int> data;

  TeamLogoBlob({
    required this.type,
    required this.data,
  });

  factory TeamLogoBlob.fromJson(Map<String, dynamic> json) =>
      _$TeamLogoBlobFromJson(json);
  Map<String, dynamic> toJson() => _$TeamLogoBlobToJson(this);

  @override
  String toString() {
    return 'TeamLogoBlob{type: $type, data: $data}';
  }
}
