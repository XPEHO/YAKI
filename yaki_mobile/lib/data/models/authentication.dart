import 'package:json_annotation/json_annotation.dart';

part "authentication.g.dart";

@JsonSerializable()
class Authentication {
  String user_id;
  String team_mate_id;
  String team_id;
  String last_name;
  String first_name;
  String email;
  String token;

  Authentication(
      {required this.user_id,
      required this.team_mate_id,
      required this.team_id,
      required this.last_name,
      required this.first_name,
      required this.email,
      required this.token});

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}
