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
      userEmail: json['user_email'] as String,
      userLogin: json['user_login'] as String,
      userPassword: json['user_password'] as String,
      teamMateId: json['team_mate_id'] as int,
      teamMateTeamId: json['team_mate_team_id'] as int,
      teamMateUserId: json['team_mate_user_id'] as int,
      declarationDate: DateTime.parse(json['declaration_date'] as String),
      declarationTeamMateId: json['declaration_team_mate_id'] as int,
      declarationId: json['declaration_id'] as int,
      declarationStatus: json['declaration_status'] as String,
    );

Map<String, dynamic> _$TeamMateModelToJson(TeamMateModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_last_name': instance.userLastName,
      'user_first_name': instance.userFirstName,
      'user_email': instance.userEmail,
      'user_login': instance.userLogin,
      'user_password': instance.userPassword,
      'team_mate_id': instance.teamMateId,
      'team_mate_team_id': instance.teamMateTeamId,
      'team_mate_user_id': instance.teamMateUserId,
      'declaration_date': instance.declarationDate.toIso8601String(),
      'declaration_team_mate_id': instance.declarationTeamMateId,
      'declaration_id': instance.declarationId,
      'declaration_status': instance.declarationStatus,
    };
