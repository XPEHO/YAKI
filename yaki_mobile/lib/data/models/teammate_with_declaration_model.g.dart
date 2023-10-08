// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teammate_with_declaration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeammateWithDeclarationModel _$TeammateWithDeclarationModelFromJson(
        Map<String, dynamic> json) =>
    TeammateWithDeclarationModel(
      userId: json['userId'] as int?,
      userLastName: json['userLastName'] as String?,
      userFirstName: json['userFirstName'] as String?,
      teamMateId: json['teamMateId'] as int?,
      declarationDate: json['declarationDate'] == null
          ? null
          : DateTime.parse(json['declarationDate'] as String),
      declarationDateStart: json['declarationDateStart'] == null
          ? null
          : DateTime.parse(json['declarationDateStart'] as String),
      declarationDateEnd: json['declarationDateEnd'] == null
          ? null
          : DateTime.parse(json['declarationDateEnd'] as String),
      declarationStatus: json['declarationStatus'] as String?,
      teamId: json['teamId'] as int?,
      teamName: json['teamName'] as String,
      declarationId: json['declarationId'] as int,
      declarationUserId: json['declarationUserId'] as int,
    );

Map<String, dynamic> _$TeammateWithDeclarationModelToJson(
        TeammateWithDeclarationModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userLastName': instance.userLastName,
      'userFirstName': instance.userFirstName,
      'teamMateId': instance.teamMateId,
      'declarationDate': instance.declarationDate?.toIso8601String(),
      'declarationDateStart': instance.declarationDateStart?.toIso8601String(),
      'declarationDateEnd': instance.declarationDateEnd?.toIso8601String(),
      'declarationStatus': instance.declarationStatus,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'declarationId': instance.declarationId,
      'declarationUserId': instance.declarationUserId,
    };
