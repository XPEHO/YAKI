// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) => TeamModel(
      teamId: json['team_id'] as int?,
      teamCaptainId: json['team_captain_id'] as int?,
      teamName: json['team_name'] as String?,
    );

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
      'team_id': instance.teamId,
      'team_captain_id': instance.teamCaptainId,
      'team_name': instance.teamName,
    };
