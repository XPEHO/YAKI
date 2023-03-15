import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_mate_repository.dart';
import 'package:yaki/data/sources/team_mate_api.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';
import 'package:yaki/presentation/state/notifiers/team_mate_notifier.dart';

final dioProvider = Provider((ref) => Dio());

final teamMateServiceProvider = Provider(
  (ref) => TeamMateApi(
    ref.read(dioProvider),
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
  ),
);
