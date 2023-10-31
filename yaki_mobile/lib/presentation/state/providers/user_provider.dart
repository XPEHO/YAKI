import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/user_repository.dart';
import 'package:yaki/data/sources/remote/user_api.dart';
import 'package:yaki/domain/entities/user_entity.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/user_notifier.dart';
import 'package:yaki/presentation/state/providers/url_provider.dart';

/// Retrieves informations from the API
final userApiProvider = Provider(
  (ref) => UserApi(
    ref.read(dioInterceptor),
    baseUrl: ref.read(urlProvider),
  ),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(ref.read(userApiProvider)),
);

/// Define a StateNotifierProvider that creates an instance of
/// the UserNotifier class
final userProvider = StateNotifierProvider<UserNotifier, UserEntity>(
  (ref) => UserNotifier(userRepository: ref.read(userRepositoryProvider)),
);
