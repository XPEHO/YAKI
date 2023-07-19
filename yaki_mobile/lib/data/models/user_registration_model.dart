import 'package:json_annotation/json_annotation.dart';

part "user_registration_model.g.dart";

@JsonSerializable()
class UserRegistrationModel {
  String? lastname;
  String? firstname;
  String? email;
  String? password;

  UserRegistrationModel({
    required this.lastname,
    required this.firstname,
    required this.email,
    required this.password,
  });

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationModelToJson(this);
}
