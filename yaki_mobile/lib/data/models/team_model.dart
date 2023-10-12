import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable()
class TeamModel {
  int teamId;
  String teamName;
  bool teamActifFlag;

  TeamModel({
    required this.teamId,
    required this.teamName,
    required this.teamActifFlag,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamModelToJson(this);

  @override
  int get hashCode => Object.hash(
        teamId.hashCode,
        teamName.hashCode,
        teamActifFlag.hashCode,
      );

  // method override for unit test purpose,
  // allow to compare instance with == operator
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TeamModel &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }
}
