import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/password_repository.dart';
import 'package:yaki/data/sources/remote/password_api.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/password_notifier.dart';
import 'package:yaki/presentation/state/providers/url_provider.dart';

final passwordApiProvider = Provider(
  (ref) => PasswordApi(
    ref.read(dioInterceptor),
    baseUrl: ref.read(urlProvider),
  ),
);

final passwordRepositoryProvider = Provider(
  (ref) => PasswordRepository(
    ref.read(passwordApiProvider),
  ),
);

final passwordProvider = StateNotifierProvider<PasswordNotifier, bool>(
  (ref) => PasswordNotifier(
    passwordRepository: ref.read(passwordRepositoryProvider),
  ),
);
