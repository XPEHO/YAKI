import 'package:json_annotation/json_annotation.dart';

part 'teammate_or_captain.g.dart';

@JsonSerializable()
class TeammateOrCaptain {
  int? captainId;
  int? teamMateId;
  int? teamId;
  int? userId;
  String? lastName;
  String? firstName;
  String? email;
  String? token;

  TeammateOrCaptain({
    required this.captainId,
    required this.teamMateId,
    required this.teamId,
    required this.userId,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.token,
  });

  factory TeammateOrCaptain.fromJson(Map<String, dynamic> json) =>
      _$TeammateOrCaptainFromJson(json);
  Map<String, dynamic> toJson() => _$TeammateOrCaptainToJson(this);
}
