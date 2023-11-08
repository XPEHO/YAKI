import 'dart:typed_data';

class AvatarEntity {
  String? avatarReference;
  Uint8List? avatar;

  AvatarEntity({
    required this.avatarReference,
    required this.avatar,
  });

  @override
  String toString() {
    return "{avatarReference: $avatarReference";
  }
}
