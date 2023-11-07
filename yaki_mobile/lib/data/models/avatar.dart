import 'package:json_annotation/json_annotation.dart';
part 'avatar.g.dart';

@JsonSerializable()
class Avatar {
  int? avatarUserId;
  String? avatarReference;
  int? avatarFile;

  Avatar({
    this.avatarUserId,
    this.avatarReference,
    this.avatarFile,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);

  @override
  String toString() {
    return "{avatarUserId: $avatarUserId, avatarReference: $avatarReference, avatarFile: $avatarFile}";
  }
}
