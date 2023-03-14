// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declaration_model_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationModelIn _$DeclarationModelInFromJson(Map<String, dynamic> json) =>
    DeclarationModelIn(
      declarationId: json['declarationId'] as int,
      declarationDate: json['declarationDate'] == null
          ? null
          : DateTime.parse(json['declarationDate'] as String),
      declarationTeamMateId: json['declarationTeamMateId'] as int,
      declarationStatus: json['declarationStatus'] as String?,
    );

Map<String, dynamic> _$DeclarationModelInToJson(DeclarationModelIn instance) =>
    <String, dynamic>{
      'declarationId': instance.declarationId,
      'declarationDate': instance.declarationDate?.toIso8601String(),
      'declarationTeamMateId': instance.declarationTeamMateId,
      'declarationStatus': instance.declarationStatus,
    };
