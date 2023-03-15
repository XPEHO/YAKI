// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_mate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMateModel _$TeamMateModelFromJson(Map<String, dynamic> json) =>
    TeamMateModel(
      userId: json['userId'] as int,
      userLastName: json['userLastName'] as String,
      userFirstName: json['userFirstName'] as String,
      userEmail: json['userEmail'] as String,
      teamMateId: json['teamMateId'] as int,
      teamMateTeamId: json['teamMateTeamId'] as int,
      teamMateUserId: json['teamMateUserId'] as int,
      declarationDate: DateTime.parse(json['declarationDate'] as String),
      declarationStatus: json['declarationStatus'] as String,
    );

Map<String, dynamic> _$TeamMateModelToJson(TeamMateModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userLastName': instance.userLastName,
      'userFirstName': instance.userFirstName,
      'userEmail': instance.userEmail,
      'teamMateId': instance.teamMateId,
      'teamMateTeamId': instance.teamMateTeamId,
      'teamMateUserId': instance.teamMateUserId,
      'declarationDate': instance.declarationDate.toIso8601String(),
      'declarationStatus': instance.declarationStatus,
    };
