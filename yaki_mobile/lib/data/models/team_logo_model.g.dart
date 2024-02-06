// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_logo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamLogoModel _$TeamLogoModelFromJson(Map<String, dynamic> json) =>
    TeamLogoModel(
      teamLogoTeamId: json['teamLogoTeamId'] as int,
      teamLogoBlob:
          TeamLogoBlob.fromJson(json['teamLogoBlob'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamLogoModelToJson(TeamLogoModel instance) =>
    <String, dynamic>{
      'teamLogoTeamId': instance.teamLogoTeamId,
      'teamLogoBlob': instance.teamLogoBlob,
    };

TeamLogoBlob _$TeamLogoBlobFromJson(Map<String, dynamic> json) => TeamLogoBlob(
      type: json['type'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$TeamLogoBlobToJson(TeamLogoBlob instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };
