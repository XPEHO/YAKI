// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declaration_model_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationModelIn _$DeclarationModelInFromJson(Map<String, dynamic> json) =>
    DeclarationModelIn(
      declarationId: json['declarationId'] as int,
      declarationUserId: json['declarationUserId'] as int,
      declarationDate: DateTime.parse(json['declarationDate'] as String),
      declarationDateStart:
          DateTime.parse(json['declarationDateStart'] as String),
      declarationDateEnd: DateTime.parse(json['declarationDateEnd'] as String),
      declarationStatus: json['declarationStatus'] as String,
      declarationTeamId: json['declarationTeamId'] as int?,
    );

Map<String, dynamic> _$DeclarationModelInToJson(DeclarationModelIn instance) =>
    <String, dynamic>{
      'declarationId': instance.declarationId,
      'declarationUserId': instance.declarationUserId,
      'declarationDate': instance.declarationDate.toIso8601String(),
      'declarationDateStart': instance.declarationDateStart.toIso8601String(),
      'declarationDateEnd': instance.declarationDateEnd.toIso8601String(),
      'declarationStatus': instance.declarationStatus,
      'declarationTeamId': instance.declarationTeamId,
    };
