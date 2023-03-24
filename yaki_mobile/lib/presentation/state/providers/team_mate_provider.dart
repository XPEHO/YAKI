import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_mate_repository.dart';
import 'package:yaki/data/sources/remote/team_mate_api.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/team_mate_notifier.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';

final teamMateServiceProvider = Provider(
  (ref) => TeamMateApi(
    ref.read(dioInterceptor),
    baseUrl: const String.fromEnvironment("API_BASE_URL"),
  ),
);

final teamMateRepositoryProvider = Provider(
  (ref) => TeamMateRepository(ref.read(teamMateServiceProvider)),
);

final teamMateProvider =
    StateNotifierProvider<TeamMateNotifier, List<TeamMateEntity>>(
  (ref) => TeamMateNotifier(
    ref.read(teamMateRepositoryProvider),
    ref.read(loginRepositoryProvider),
  ),
);
