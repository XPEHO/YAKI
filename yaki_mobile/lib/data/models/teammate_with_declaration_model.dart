import 'package:json_annotation/json_annotation.dart';

part 'teammate_with_declaration_model.g.dart';

@JsonSerializable()
class TeammateWithDeclarationModel {
  int? userId;
  String? userLastName;
  String? userFirstName;
  DateTime? declarationDate;
  DateTime? declarationDateStart;
  DateTime? declarationDateEnd;
  String? declarationStatus;
  int? teamId;
  String? teamName;
  int? customerId;
  String? customerName;
  String? avatarReference;
  List<dynamic>? avatarByteArray;

  TeammateWithDeclarationModel({
    required this.userId,
    required this.userLastName,
    required this.userFirstName,
    required this.declarationDate,
    required this.declarationDateStart,
    required this.declarationDateEnd,
    required this.declarationStatus,
    required this.teamId,
    required this.teamName,
    required this.customerId,
    required this.customerName,
    required this.avatarReference,
    required this.avatarByteArray,
  });

  factory TeammateWithDeclarationModel.fromJson(Map<String, dynamic> json) =>
      _$TeammateWithDeclarationModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeammateWithDeclarationModelToJson(this);
}
