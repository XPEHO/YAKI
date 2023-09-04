// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      captainId: json['captainId'] as int?,
      teammateId: json['teammateId'] as int?,
      teamId: json['teamId'] as int?,
      userId: json['userId'] as int?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'captainId': instance.captainId,
      'teammateId': instance.teammateId,
      'teamId': instance.teamId,
      'userId': instance.userId,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'email': instance.email,
      'token': instance.token,
    };
