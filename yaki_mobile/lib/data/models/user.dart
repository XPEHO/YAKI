import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? captainId;
  int? teamMateId;
  int? teamId;
  int? userId;
  String? lastName;
  String? firstName;
  String? email;
  String? token;

  User({
    required this.captainId,
    required this.teamMateId,
    required this.teamId,
    required this.userId,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
