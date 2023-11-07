import 'dart:io';

class AvatarEntity {
  String? avatarReference;
  File? avatar;

  AvatarEntity({
    required this.avatarReference,
    required this.avatar,
  });

  @override
  String toString() {
    return "{avatarReference: $avatarReference, avatarFile: $avatar";
  }
}
