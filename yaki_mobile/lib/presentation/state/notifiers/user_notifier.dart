import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/user_info_profile.dart';
import 'package:yaki/data/repositories/user_repository.dart';
import 'package:yaki/domain/entities/user_entity.dart';

class UserNotifier extends StateNotifier<UserEntity> {
  final UserRepository userRepository;

  UserNotifier({required this.userRepository})
      : super(
          UserEntity(lastName: '', firstName: '', email: ''
              //, avatarId: 0
              ),
        );

  Future<void> getUser() async {
    final UserInfoProfile user = await userRepository.getUserById();

    state = UserEntity(
      lastName: user.lastName,
      firstName: user.firstName,
      email: user.email,
      //avatarId: user.avatarId,
    );
  }
}
