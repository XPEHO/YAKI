import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/data/sources/remote/team_api.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/team_notifier.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';

// Define a provider that creates an instance of the TeamApi class
final teamServiceProvider = Provider(
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
  (ref) => TeamRepository(ref.read(teamServiceProvider)),
);

/// Define a StateNotifierProvider that creates an instance of
/// the TeamNotifier class
final teamProvider = StateNotifierProvider<TeamNotifier, List<TeamModel>>(
  (ref) => TeamNotifier(
    ref.read(teamRepositoryProvider),
    ref.read(loginRepositoryProvider),
  ),
);
