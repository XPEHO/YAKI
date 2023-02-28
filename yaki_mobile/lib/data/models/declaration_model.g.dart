// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declaration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationModel _$DeclarationModelFromJson(Map<String, dynamic> json) =>
    DeclarationModel(
      declaration_date: DateTime.parse(json['declaration_date'] as String),
      declaration_team_mate_id: json['declaration_team_mate_id'] as int,
      declaration_status: json['declaration_status'] as String,
    );

Map<String, dynamic> _$DeclarationModelToJson(DeclarationModel instance) =>
    <String, dynamic>{
      'declaration_date': instance.declaration_date.toIso8601String(),
      'declaration_team_mate_id': instance.declaration_team_mate_id,
      'declaration_status': instance.declaration_status,
    };
