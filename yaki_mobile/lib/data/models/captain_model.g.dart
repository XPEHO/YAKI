// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptainModel _$CaptainModelFromJson(Map<String, dynamic> json) => CaptainModel(
      teamMateId: json['teamMateId'] as int,
      teamMateTeamId: json['teamMateTeamId'] as int,
      teamMateUserId: json['teamMateUserId'] as int,
      userId: json['userId'] as int,
      userLastName: json['userLastName'] as String,
      userFirstName: json['userFirstName'] as String,
      userMail: json['userMail'] as String,
      userLogin: json['userLogin'] as String,
      userPassword: json['userPassword'] as String,
    );

Map<String, dynamic> _$CaptainModelToJson(CaptainModel instance) =>
    <String, dynamic>{
      'teamMateId': instance.teamMateId,
      'teamMateTeamId': instance.teamMateTeamId,
      'teamMateUserId': instance.teamMateUserId,
      'userId': instance.userId,
      'userLastName': instance.userLastName,
      'userFirstName': instance.userFirstName,
      'userMail': instance.userMail,
      'userLogin': instance.userLogin,
      'userPassword': instance.userPassword,
    };
