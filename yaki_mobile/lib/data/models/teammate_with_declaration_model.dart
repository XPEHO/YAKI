import 'package:json_annotation/json_annotation.dart';

part 'teammate_with_declaration_model.g.dart';

@JsonSerializable()
class TeammateWithDeclarationModel {
  int? userId;
  String? userLastName;
  String? userFirstName;
  int? teamMateId;
  DateTime? declarationDate;
  DateTime? declarationDateStart;
  DateTime? declarationDateEnd;
  String? declarationStatus;
  int? teamId;
  String teamName;
  int declarationId;
  int declarationUserId;

  TeammateWithDeclarationModel({
    required this.userId,
    required this.userLastName,
    required this.userFirstName,
    required this.teamMateId,
    required this.declarationDate,
    required this.declarationDateStart,
    required this.declarationDateEnd,
    required this.declarationStatus,
    required this.teamId,
    required this.teamName,
    required this.declarationId,
    required this.declarationUserId,
  });

  factory TeammateWithDeclarationModel.fromJson(Map<String, dynamic> json) =>
      _$TeammateWithDeclarationModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeammateWithDeclarationModelToJson(this);
}
