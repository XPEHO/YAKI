import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/data/sources/remote/team_api.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/team_notifier.dart';
import 'package:yaki/presentation/state/state/team_page_state.dart';

// Define a provider that creates an instance of the TeamApi class
final teamApiProvider = Provider(
  (ref) => TeamApi(
    // Takes in a dioInterceptor provider to configure Dio
    ref.read(dioInterceptor),
    // Read the API base URL from an environment variable
    baseUrl: const String.fromEnvironment("API_BASE_URL"),
  ),
);

// Define a provider that creates an instance of the TeamRepository class
final teamRepositoryProvider = Provider(
  // Takes in the teamServiceProvider provider
  (ref) => TeamRepository(ref.read(teamApiProvider)),
);

/// Define a StateNotifierProvider that creates an instance of
/// the TeamNotifier class
final teamProvider = StateNotifierProvider<TeamNotifier, TeamPageState>(
  (ref) => TeamNotifier(
    ref.read(teamRepositoryProvider),
  ),
);
