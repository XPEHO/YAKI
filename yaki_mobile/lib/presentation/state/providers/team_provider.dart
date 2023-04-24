import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/data/sources/remote/team_api.dart';
import 'package:yaki/domain/entities/team_entity.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/team_notifier.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';

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
final teamProvider = StateNotifierProvider<TeamNotifier, List<TeamEntity>>(
  (ref) => TeamNotifier(
    ref.read(teamRepositoryProvider),
    ref.read(loginRepositoryProvider),
  ),
);
