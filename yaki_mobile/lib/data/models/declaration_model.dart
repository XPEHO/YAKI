import 'package:json_annotation/json_annotation.dart';

part 'declaration_model.g.dart';

@JsonSerializable()
class DeclarationModel {
  DateTime declarationDate;
  DateTime declarationDateStart;
  DateTime declarationDateEnd;
  int? declarationTeamMateId;
  String declarationStatus;
  int? declarationTeamId;

  // Remote, On site, Vacation, Other
  DeclarationModel({
    required this.declarationDate,
    required this.declarationDateStart,
    required this.declarationDateEnd,
    required this.declarationTeamMateId,
    required this.declarationStatus,
    required this.declarationTeamId,
  });

  factory DeclarationModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeclarationModelToJson(this);
}
