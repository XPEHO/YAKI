// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      userId: json['userId'] as int?,
      teamMateId: json['teamMateId'] as int?,
      teamId: json['teamId'] as int?,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'teamMateId': instance.teamMateId,
      'teamId': instance.teamId,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'email': instance.email,
      'token': instance.token,
    };
