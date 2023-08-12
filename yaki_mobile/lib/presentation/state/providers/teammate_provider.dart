import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/teammate_repository.dart';
import 'package:yaki/data/sources/remote/teammate_api.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/teammate_notifier.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';

/// Retrieves informations from the API
final teammateServiceProvider = Provider(
  (ref) => TeammateApi(
    ref.read(dioInterceptor),
    baseUrl: const String.fromEnvironment("API_BASE_URL"),
  ),
);

// Define a provider that creates an instance of the TeamMateRepository class
final teammateRepositoryProvider = Provider(
  (ref) => TeammateRepository(ref.read(teammateServiceProvider)),
);

/// Retrieves data from the team_mate_notifier.dart
final teammateProvider =
    StateNotifierProvider<TeammateNotifier, List<TeammateEntity>>(
  (ref) => TeammateNotifier(
    ref.read(teammateRepositoryProvider),
    ref.read(loginRepositoryProvider),
  ),
);
