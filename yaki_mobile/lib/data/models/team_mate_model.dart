import 'package:json_annotation/json_annotation.dart';

part 'team_mate_model.g.dart';

@JsonSerializable()
class TeamMateModel {
  int? userId;
<<<<<<< HEAD

  String? userLastName;

  String? userFirstName;

  int? teamMateId;

  DateTime? declarationDate;

=======
  String? userLastName;
  String? userFirstName;
  int? teamMateId;
  DateTime? declarationDate;
>>>>>>> 8d96542 (test(front): add captain modification for testing)
  String? declarationStatus;

  TeamMateModel({
    required this.userId,
    required this.userLastName,
    required this.userFirstName,
    required this.teamMateId,
    required this.declarationDate,
    required this.declarationStatus,
  });

  factory TeamMateModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamMateModelToJson(this);
}