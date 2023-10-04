import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/state/notifiers/declaration_notifier.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';

final declarationApiProvider = Provider(
  (ref) => DeclarationApi(
    ref.read(dioInterceptor),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

final declarationRepositoryProvider = Provider(
  (ref) => DeclarationRepository(
    ref.read(declarationApiProvider),
  ),
);

final declarationProvider =
    StateNotifierProvider<DeclarationNotifier, DeclarationStatus>(
  (ref) => DeclarationNotifier(
    declarationRepository: ref.read(declarationRepositoryProvider),
    teamRepository: ref.read(teamRepositoryProvider),
  ),
);
