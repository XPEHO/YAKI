import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/presentation/state/notifiers/declaration_notifier.dart';
import 'package:yaki/presentation/state/providers/dio_provider.dart';

final dioproviderClean = Provider((ref) => Dio());

final declarationApiProvider = Provider(
  (ref) => DeclarationApi(
    ref.read(dioProviderInterceptor),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

final declarationRepositoryProvider = Provider(
  (ref) => DeclarationRepository(
    ref.read(declarationApiProvider),
  ),
);

final declarationProvider =
    StateNotifierProvider<DeclarationNotifier, dynamic>(
  (ref) => DeclarationNotifier(
    ref.read(declarationRepositoryProvider),
  ),
);
