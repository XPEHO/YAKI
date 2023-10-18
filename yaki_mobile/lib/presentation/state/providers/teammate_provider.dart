import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/teammate_repository.dart';
import 'package:yaki/data/sources/remote/teammate_api.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';

import 'package:yaki/presentation/state/providers/url_provider.dart';

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
