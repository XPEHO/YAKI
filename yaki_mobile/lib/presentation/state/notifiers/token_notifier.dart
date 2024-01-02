import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/token_repository.dart';

class TokenNotifier extends StateNotifier<bool> {
  final TokenRepository tokenRepository;

  TokenNotifier({
    required this.tokenRepository,
  }) : super(false);

  Future<void> verifyTokenValidity() async {
    state = await tokenRepository.verifyTokenValidity();
  }
}
