import 'package:json_annotation/json_annotation.dart';

part 'teammate_model.g.dart';

@JsonSerializable()
class TeammateModel {
  int? userId;
  String? userLastName;
  String? userFirstName;
  int? teamMateId;
  DateTime? declarationDate;
  String? declarationStatus;

  TeammateModel({
    required this.userId,
    required this.userLastName,
    required this.userFirstName,
    required this.teamMateId,
    required this.declarationDate,
    required this.declarationStatus,
  });

  factory TeammateModel.fromJson(Map<String, dynamic> json) =>
      _$TeammateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeammateModelToJson(this);
}
