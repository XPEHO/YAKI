// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationModel _$UserRegistrationModelFromJson(
        Map<String, dynamic> json) =>
    UserRegistrationModel(
      lastname: json['lastname'] as String?,
      firstname: json['firstname'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserRegistrationModelToJson(
        UserRegistrationModel instance) =>
    <String, dynamic>{
      'lastname': instance.lastname,
      'firstname': instance.firstname,
      'email': instance.email,
      'password': instance.password,
    };
