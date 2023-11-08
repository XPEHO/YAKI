import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/avatar_repository.dart';
import 'package:yaki/domain/entities/avatar_entity.dart';

class AvatarNotifier extends StateNotifier<AvatarEntity> {
  final AvatarRepository avatarRepository;

  AvatarNotifier({required this.avatarRepository})
      : super(
          AvatarEntity(avatar: null, avatarReference: null),
        );

  Future<void> postAvatar(
    String avatarReference,
    File? fileName,
  ) async {
    state = await avatarRepository.postAvatarById(
      avatarReference: avatarReference,
      avatar: fileName,
    );
  }

  Future<void> getAvatar() async {
    state = await avatarRepository.getAvatarById();
  }
}
