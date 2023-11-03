import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/teammate_repository.dart';
import 'package:yaki/data/sources/remote/teammate_api.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/teammate_notifier.dart';

import 'package:yaki/presentation/state/providers/url_provider.dart';
import 'package:yaki/presentation/state/state/state_teammate_page.dart';

/// Retrieves informations from the API
final teammateServiceProvider = Provider(
  (ref) => TeammateApi(
    ref.read(dioInterceptor),
    baseUrl: ref.read(urlProvider),
  ),
);

// Define a provider that creates an instance of the TeamMateRepository class
final teammateRepositoryProvider = Provider(
  (ref) => TeammateRepository(ref.read(teammateServiceProvider)),
);

/// Define a StateNotifierProvider that creates an instance of
/// the TeamMateNotifier class
final teammateNotifierProvider =
    StateNotifierProvider<TeammateNotifier, StateTeamMate>(
  (ref) => TeammateNotifier(),
);
