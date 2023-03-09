// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_mate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMateModel _$TeamMateModelFromJson(Map<String, dynamic> json) =>
    TeamMateModel(
      team_mate_id: json['team_mate_id'] as int,
      user_id: json['user_id'] as int,
      team_id: json['team_id'] as int,
      last_name: json['last_name'] as String,
      first_name: json['first_name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$TeamMateModelToJson(TeamMateModel instance) =>
    <String, dynamic>{
      'team_mate_id': instance.team_mate_id,
      'user_id': instance.user_id,
      'team_id': instance.team_id,
      'last_name': instance.last_name,
      'first_name': instance.first_name,
      'email': instance.email,
      'token': instance.token,
    };
