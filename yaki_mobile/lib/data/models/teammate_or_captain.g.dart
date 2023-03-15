// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teammate_or_captain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeammateOrCaptain _$TeammateOrCaptainFromJson(Map<String, dynamic> json) =>
    TeammateOrCaptain(
      captainId: json['captainId'] as int?,
      teamMateId: json['teamMateId'] as int?,
      teamId: json['teamId'] as int?,
      userId: json['userId'] as int?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$TeammateOrCaptainToJson(TeammateOrCaptain instance) =>
    <String, dynamic>{
      'captainId': instance.captainId,
      'teamMateId': instance.teamMateId,
      'teamId': instance.teamId,
      'userId': instance.userId,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'email': instance.email,
      'token': instance.token,
    };
