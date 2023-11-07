import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/avatar.dart';
import 'package:yaki/data/repositories/avatar_repository.dart';
import 'package:yaki/domain/entities/avatar_entity.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';

class AvatarNotifier extends StateNotifier<AvatarEntity> {
  final AvatarRepository avatarRepository;

  AvatarNotifier({required this.avatarRepository})
      : super(
          AvatarEntity(
            avatarUserId: 1,
            avatarReference: 'userPicture',
            avatarFile: null,
          ),
        );

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

  Future<void> postAvatar(
    String avatarReference,
    String? fileName,
  ) async {
    FutureProvider.autoDispose<AvatarEntity>((ref) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt("userId");
      print(userId);
      if (userId == null) throw Exception("User ID is null");

      final Avatar avatar =
          await ref.watch(avatarRepositoryProvider).postAvatarById();
      print(Avatar);
      print(avatar.avatarReference);
      print(avatar.avatarFile);
      print(avatar.avatarUserId);

      state = AvatarEntity(
        avatarUserId: avatar.avatarUserId,
        avatarReference: avatar.avatarReference,
        avatarFile: avatar.avatarFile,
      );

      return state;
    });
  }
}
