import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/avatar_repository.dart';
import 'package:yaki/data/sources/remote/avatar_api.dart';
import 'package:yaki/domain/entities/avatar_entity.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/avatar_notifier.dart';
import 'package:yaki/presentation/state/providers/url_provider.dart';

/// Retrieves informations from the API
final avatarApiProvider = Provider(
  (ref) => AvatarApi(
    ref.read(dioInterceptor),
    baseUrl: ref.read(urlProvider),
  ),
);

final avatarRepositoryProvider = Provider<AvatarRepository>(
  (ref) => AvatarRepository(ref.read(avatarApiProvider)),
);

/// Define a StateNotifierProvider that creates an instance of
/// the AvatarNotifier class
final avatarProvider = StateNotifierProvider<AvatarNotifier, AvatarEntity>(
  (ref) => AvatarNotifier(avatarRepository: ref.read(avatarRepositoryProvider)),
);
