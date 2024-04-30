import 'package:json_annotation/json_annotation.dart';

part 'declaration_model.g.dart';

@JsonSerializable()
class DeclarationModel {
  int? declarationUserId;
  DateTime declarationDate;
  DateTime declarationDateStart;
  DateTime declarationDateEnd;
  String declarationStatus;
  int? declarationTeamId;

  // Remote, On site, Absence
  DeclarationModel({
    required this.declarationUserId,
    required this.declarationDate,
    required this.declarationDateStart,
    required this.declarationDateEnd,
    required this.declarationStatus,
    required this.declarationTeamId,
  });

  factory DeclarationModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeclarationModelToJson(this);
}
