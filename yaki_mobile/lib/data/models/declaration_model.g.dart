// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declaration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationModel _$DeclarationModelFromJson(Map<String, dynamic> json) =>
    DeclarationModel(
      declarationDate: DateTime.parse(json['declarationDate'] as String),
      declarationTeamMateId: json['declarationTeamMateId'] as int,
      declarationStatus: json['declarationStatus'] as String,
    );

Map<String, dynamic> _$DeclarationModelToJson(DeclarationModel instance) =>
    <String, dynamic>{
      'declarationDate': instance.declarationDate.toIso8601String(),
      'declarationTeamMateId': instance.declarationTeamMateId,
      'declarationStatus': instance.declarationStatus,
    };
