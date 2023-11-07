class AvatarEntity {
  int? avatarUserId;
  String? avatarReference;
  int? avatarFile;

  AvatarEntity({
    required this.avatarUserId,
    required this.avatarReference,
    required this.avatarFile,
  });

  @override
  String toString() {
    return "{avatarUserId: $avatarUserId, avatarReference: $avatarReference, avatarFile: $avatarFile";
  }
}
