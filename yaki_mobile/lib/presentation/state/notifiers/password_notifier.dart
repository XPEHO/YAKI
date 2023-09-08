import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/password_repository.dart';

class PasswordNotifier extends StateNotifier<bool> {
  final PasswordRepository passwordRepository;

  PasswordNotifier({required this.passwordRepository}) : super(false);

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    state =
        await passwordRepository.changePassword(currentPassword, newPassword);
  }
}
