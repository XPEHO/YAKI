import 'package:json_annotation/json_annotation.dart';

part 'declaration_model.g.dart';

@JsonSerializable()
class DeclarationModel {
  DateTime declaration_date;
  int declaration_team_mate_id;
  String declaration_status;

  // Remote, On site, Vacation, Other
  DeclarationModel({
    required this.declaration_date,
    required this.declaration_team_mate_id,
    required this.declaration_status,
  });

  factory DeclarationModel.fromJson(Map<String, dynamic> json) => _$DeclarationModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeclarationModelToJson(this);
}
