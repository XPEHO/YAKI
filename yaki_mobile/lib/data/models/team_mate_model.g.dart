// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_mate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMateModel _$TeamMateModelFromJson(Map<String, dynamic> json) =>
    TeamMateModel(
      user_id: json['user_id'] as int,
      user_last_name: json['user_last_name'] as String,
      user_first_name: json['user_first_name'] as String,
      user_email: json['user_email'] as String,
      team_mate_id: json['team_mate_id'] as int,
      team_mate_team_id: json['team_mate_team_id'] as int,
      team_mate_user_id: json['team_mate_user_id'] as int,
      declaration_date: DateTime.parse(json['declaration_date'] as String),
      declaration_status: json['declaration_status'] as String,
    );

Map<String, dynamic> _$TeamMateModelToJson(TeamMateModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'user_last_name': instance.user_last_name,
      'user_first_name': instance.user_first_name,
      'user_email': instance.user_email,
      'team_mate_id': instance.team_mate_id,
      'team_mate_team_id': instance.team_mate_team_id,
      'team_mate_user_id': instance.team_mate_user_id,
      'declaration_date': instance.declaration_date.toIso8601String(),
      'declaration_status': instance.declaration_status,
    };
