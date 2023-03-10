// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      userId: json['user_id'] as int?,
      teamMateId: json['team_mate_id'] as int?,
      teamId: json['team_id'] as int?,
      lastName: json['last_name'] as String,
      firstName: json['first_name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'team_mate_id': instance.teamMateId,
      'team_id': instance.teamId,
      'last_name': instance.lastName,
      'first_name': instance.firstName,
      'email': instance.email,
      'token': instance.token,
    };
