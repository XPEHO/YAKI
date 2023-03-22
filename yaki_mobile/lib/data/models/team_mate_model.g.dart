// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_mate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMateModel _$TeamMateModelFromJson(Map<String, dynamic> json) =>
    TeamMateModel(
      userId: json['user_id'] as int,
      userLastName: json['user_last_name'] as String,
      userFirstName: json['user_first_name'] as String,
      teamMateId: json['team_mate_id'] as int,
      declarationDate: json['declaration_date'] == null
          ? null
          : DateTime.parse(json['declaration_date'] as String),
      declarationStatus: json['declaration_status'] as String?,
    );

Map<String, dynamic> _$TeamMateModelToJson(TeamMateModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_last_name': instance.userLastName,
      'user_first_name': instance.userFirstName,
      'team_mate_id': instance.teamMateId,
      'declaration_date': instance.declarationDate?.toIso8601String(),
      'declaration_status': instance.declarationStatus,
    };
