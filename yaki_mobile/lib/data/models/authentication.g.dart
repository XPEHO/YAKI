// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      user_id: json['user_id'] as String,
      team_mate_id: json['team_mate_id'] as String,
      team_id: json['team_id'] as String,
      last_name: json['last_name'] as String,
      first_name: json['first_name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'team_mate_id': instance.team_mate_id,
      'team_id': instance.team_id,
      'last_name': instance.last_name,
      'first_name': instance.first_name,
      'email': instance.email,
      'token': instance.token,
    };
