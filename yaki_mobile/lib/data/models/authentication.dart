import 'package:json_annotation/json_annotation.dart';

part "authentication.g.dart";

@JsonSerializable()
class Authentication {
  int? userId;
  int? teamMateId;
  int? teamId;
  String lastName;
  String firstName;
  String email;
  String token;

  Authentication({
    required this.userId,
    required this.teamMateId,
    required this.teamId,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.token,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}
