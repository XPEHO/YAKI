import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/user.dart';
import 'package:yaki/data/repositories/user_repository.dart';
import 'package:yaki/domain/entities/user_entity.dart';

class UserNotifier extends StateNotifier<UserEntity> {
  final UserRepository userRepository;

  UserNotifier({required this.userRepository})
      : super(
          UserEntity(userId: 0, lastName: '', firstName: '', email: ''),
        );

  Future<void> getUser() async {
    final User user = await userRepository.getUserById();

    state = UserEntity(
      userId: user.userId,
      lastName: user.lastName,
      firstName: user.firstName,
      email: user.email,
    );
  }
}
