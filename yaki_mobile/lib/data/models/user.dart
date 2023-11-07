import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? captainId;
  int? teammateId;
  int? teamId;
  int? userId;
  String? lastName;
  String? firstName;
  String? email;
  String? token;
  //int? avatarId;

  User({
    required this.captainId,
    required this.teammateId,
    required this.teamId,
    required this.userId,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.token,
    //required this.avatarId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "{captainId: $captainId, teammateId: $teammateId, teamId: $teamId, userId: $userId, lastName: $lastName, firstName: $firstName, email: $email, token: $token}";
  }
}
