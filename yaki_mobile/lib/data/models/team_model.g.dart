// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) => TeamModel(
      teamId: json['teamId'] as int?,
      teamCaptainId: json['teamCaptainId'] as int?,
      teamName: json['teamName'] as String?,
    );

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
      'teamId': instance.teamId,
      'teamCaptainId': instance.teamCaptainId,
      'teamName': instance.teamName,
    };
