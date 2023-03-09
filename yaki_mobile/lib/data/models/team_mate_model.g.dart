// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_mate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMateModel _$TeamMateModelFromJson(Map<String, dynamic> json) =>
    TeamMateModel(
      teamMateId: json['teamMateId'] as int,
      userId: json['userId'] as int,
      teamId: json['teamId'] as int,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$TeamMateModelToJson(TeamMateModel instance) =>
    <String, dynamic>{
      'teamMateId': instance.teamMateId,
      'userId': instance.userId,
      'teamId': instance.teamId,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'email': instance.email,
      'token': instance.token,
    };
