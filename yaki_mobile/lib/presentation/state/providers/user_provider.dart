import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/user_repository.dart';
import 'package:yaki/data/sources/remote/user_api.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/providers/url_provider.dart';

/// Retrieves informations from the API
final userApiProvider = Provider(
  (ref) => UserApi(
    ref.read(dioInterceptor),
    baseUrl: ref.read(urlProvider),
  ),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(ref.read(userApiProvider), ),
);
