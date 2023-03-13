import 'package:json_annotation/json_annotation.dart';

part 'declaration_model_in.g.dart';

@JsonSerializable()
class DeclarationModelIn {
  int? declarationId;
  DateTime? declarationDate;
  int? declarationTeamMateId;
  String? declarationStatus;

  // Remote, On site, Vacation, Other
  DeclarationModelIn({
    required this.declarationId,
    required this.declarationDate,
    required this.declarationTeamMateId,
    required this.declarationStatus,
  });

  factory DeclarationModelIn.fromJson(Map<String, dynamic> json) =>
      _$DeclarationModelInFromJson(json);
  Map<String, dynamic> toJson() => _$DeclarationModelInToJson(this);
}
