// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declaration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationModel _$DeclarationModelFromJson(Map<String, dynamic> json) =>
    DeclarationModel(
      declarationDate: DateTime.parse(json['declarationDate'] as String),
      declarationDateStart:
          DateTime.parse(json['declarationDateStart'] as String),
      declarationDateEnd: DateTime.parse(json['declarationDateEnd'] as String),
      declarationTeamMateId: json['declarationTeamMateId'] as int?,
      declarationStatus: json['declarationStatus'] as String,
      declarationTeamId: json['declarationTeamId'] as int?,
    );

Map<String, dynamic> _$DeclarationModelToJson(DeclarationModel instance) =>
    <String, dynamic>{
      'declarationDate': instance.declarationDate.toIso8601String(),
      'declarationDateStart': instance.declarationDateStart.toIso8601String(),
      'declarationDateEnd': instance.declarationDateEnd.toIso8601String(),
      'declarationTeamMateId': instance.declarationTeamMateId,
      'declarationStatus': instance.declarationStatus,
      'declarationTeamId': instance.declarationTeamId,
    };
