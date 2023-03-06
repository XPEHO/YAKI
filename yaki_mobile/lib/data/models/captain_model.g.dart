// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptainModel _$CaptainModelFromJson(Map<String, dynamic> json) => CaptainModel(
      team_mate_id: json['team_mate_id'] as int,
      team_mate_team_id: json['team_mate_team_id'] as int,
      team_mate_user_id: json['team_mate_user_id'] as int,
      user_id: json['user_id'] as int,
      user_last_name: json['user_last_name'] as String,
      user_first_name: json['user_first_name'] as String,
      user_mail: json['user_mail'] as String,
      user_login: json['user_login'] as String,
      user_password: json['user_password'] as String,
    );

Map<String, dynamic> _$CaptainModelToJson(CaptainModel instance) =>
    <String, dynamic>{
      'team_mate_id': instance.team_mate_id,
      'team_mate_team_id': instance.team_mate_team_id,
      'team_mate_user_id': instance.team_mate_user_id,
      'user_id': instance.user_id,
      'user_last_name': instance.user_last_name,
      'user_first_name': instance.user_first_name,
      'user_mail': instance.user_mail,
      'user_login': instance.user_login,
      'user_password': instance.user_password,
    };
