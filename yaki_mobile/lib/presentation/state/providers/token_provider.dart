import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/token_repository.dart';
import 'package:yaki/data/sources/remote/token_api.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/providers/url_provider.dart';

final tokenApiProvider = Provider(
  (ref) => TokenApi(
    ref.read(dioInterceptor),
    baseUrl: ref.read(urlProvider),
  ),
);

final tokenRepositoryProvider = Provider<TokenRepository>(
  (ref) => TokenRepository(ref.read(tokenApiProvider)),
);
