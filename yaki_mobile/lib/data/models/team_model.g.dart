// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) => TeamModel(
      teamId: json['teamId'] as int,
      teamName: json['teamName'] as String,
      teamActifFlag: json['teamActifFlag'] as bool,
    );

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamActifFlag': instance.teamActifFlag,
    };
