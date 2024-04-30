import 'package:json_annotation/json_annotation.dart';

part 'declaration_model_in.g.dart';

@JsonSerializable()
class DeclarationModelIn {
  int declarationId;
  int declarationUserId;
  DateTime declarationDate;
  DateTime declarationDateStart;
  DateTime declarationDateEnd;
  String declarationStatus;
  int? declarationTeamId;

  // Remote, On site, Absence
  DeclarationModelIn({
    required this.declarationId,
    required this.declarationUserId,
    required this.declarationDate,
    required this.declarationDateStart,
    required this.declarationDateEnd,
    required this.declarationStatus,
    required this.declarationTeamId,
  });

  factory DeclarationModelIn.fromJson(Map<String, dynamic> json) =>
      _$DeclarationModelInFromJson(json);
  Map<String, dynamic> toJson() => _$DeclarationModelInToJson(this);
}
