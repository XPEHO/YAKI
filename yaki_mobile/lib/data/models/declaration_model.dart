import 'package:json_annotation/json_annotation.dart';

part 'declaration_model.g.dart';

@JsonSerializable()
class DeclarationModel {
  DateTime declarationDate;
  int? declarationTeamMateId;
  String declarationStatus;

  // Remote, On site, Vacation, Other
  DeclarationModel({
    required this.declarationDate,
    required this.declarationTeamMateId,
    required this.declarationStatus,
  });

  factory DeclarationModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeclarationModelToJson(this);

  @override
  String toString() {
    return 'DeclarationModel(declarationDate: $declarationDate, declarationTeamMateId: $declarationTeamMateId, declarationStatus: $declarationStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeclarationModel &&
        other.declarationDate == declarationDate &&
        other.declarationTeamMateId == declarationTeamMateId &&
        other.declarationStatus == declarationStatus;
  }

  @override
  int get hashCode {
    return declarationDate.hashCode ^
        declarationTeamMateId.hashCode ^
        declarationStatus.hashCode;
  }
}
