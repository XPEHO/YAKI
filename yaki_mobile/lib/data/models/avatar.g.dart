// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Avatar _$AvatarFromJson(Map<String, dynamic> json) => Avatar(
      avatarUserId: json['avatarUserId'] as int?,
      avatarReference: json['avatarReference'] as String?,
      avatarFile: json['avatarFile'] as int?,
    );

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'avatarUserId': instance.avatarUserId,
      'avatarReference': instance.avatarReference,
      'avatarFile': instance.avatarFile,
    };
