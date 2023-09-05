// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_changement_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordChangementOut _$PasswordChangementOutFromJson(
        Map<String, dynamic> json) =>
    PasswordChangementOut(
      userId: json['userId'] as int,
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$PasswordChangementOutToJson(
        PasswordChangementOut instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
    };
