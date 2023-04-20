import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/team_repository.dart';
import '../../../data/sources/remote/team_api.dart';
import '../../../domain/entities/team_entity.dart';
import '../dio/dio_interceptor.dart';
import '../notifiers/team_notifier.dart';
import 'login_provider.dart';

final teamServiceProvider = Provider(
      (ref) => TeamApi(
    ref.read(dioInterceptor),
    baseUrl: const String.fromEnvironment("API_BASE_URL"),
  ),
);

final teamRepositoryProvider = Provider(
      (ref) => TeamRepository(ref.read(teamServiceProvider)),
);

/// Retrieves data from the team_notifier.dart
final teamProvider =
StateNotifierProvider<TeamNotifier, List<TeamEntity>>(
      (ref) => TeamNotifier(
    ref.read(teamRepositoryProvider),
    ref.read(loginRepositoryProvider),
  ),
);