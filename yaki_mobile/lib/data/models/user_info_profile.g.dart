// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoProfile _$UserInfoProfileFromJson(Map<String, dynamic> json) =>
    UserInfoProfile(
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      avatarChoice: json['avatarChoice'] as String?,
    );

Map<String, dynamic> _$UserInfoProfileToJson(UserInfoProfile instance) =>
    <String, dynamic>{
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'email': instance.email,
      'avatarChoice': instance.avatarChoice,
    };
