import 'package:json_annotation/json_annotation.dart';

part 'user_info_profile.g.dart';

@JsonSerializable()
class UserInfoProfile {
  String? lastName;
  String? firstName;
  String? email;
  String? avatarChoice;

  UserInfoProfile({
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.avatarChoice,
  });

  factory UserInfoProfile.fromJson(Map<String, dynamic> json) =>
      _$UserInfoProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoProfileToJson(this);

  @override
  String toString() {
    return 'UserInfoProfile(lastName: $lastName, firstName: $firstName, email: $email, avatar: $avatarChoice)';
  }
}
