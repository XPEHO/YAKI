// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_mate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMateModel _$TeamMateModelFromJson(Map<String, dynamic> json) =>
    TeamMateModel(
      userId: json['userId'] as int?,
      userLastName: json['userLastName'] as String?,
      userFirstName: json['userFirstName'] as String?,
      teamMateId: json['teamMateId'] as int?,
      declarationDate: json['declarationDate'] == null
          ? null
          : DateTime.parse(json['declarationDate'] as String),
      declarationStatus: json['declarationStatus'] as String?,
    );

Map<String, dynamic> _$TeamMateModelToJson(TeamMateModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userLastName': instance.userLastName,
      'userFirstName': instance.userFirstName,
      'teamMateId': instance.teamMateId,
      'declarationDate': instance.declarationDate?.toIso8601String(),
      'declarationStatus': instance.declarationStatus,
    };
