import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/avatar_repository.dart';
import 'package:yaki/domain/entities/avatar_entity.dart';

class AvatarNotifier extends StateNotifier<AvatarEntity> {
  final AvatarRepository avatarRepository;

  AvatarNotifier({required this.avatarRepository})
      : super(
          AvatarEntity(avatar: File(''), avatarReference: "avatarNone"),
        );

  Future<void> postAvatar(
    String avatarReference,
    File? fileName,
  ) async {
    await avatarRepository.postAvatarById(
      avatarReference: avatarReference,
      avatar: fileName,
    );
  }

  // Future<void> getAvatar() async {
  //   final Avatar avatar = await AvatarRepository.getAvatarById();

  //   state = AvatarEntity(
  //     avatarId: avatar.avatarId,
  //     avatarUserId: avatar.avatarUserId,
  //     avatarReference: avatar.avatarReference,
  //     avatarBlob: avatar.avatarBlob,
  //     avatarIsValidated: avatar.avatarIsValidated,
  //   );
  // }
}
