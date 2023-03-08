import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/team_mate_model.dart';


import 'package:yaki/data/sources/team_mate_api.dart';

import 'package:yaki/data/repositories/team_mate_repository.dart';
import 'package:yaki/presentation/state/notifiers/team_mate_notifier.dart';

final dioProvider = Provider((ref) => Dio());

final TeamMateServiceProvider = Provider(
        (ref) => TeamMateApi(
            ref.read(dioProvider),
            baseUrl: const String.fromEnvironment('API_BASE_URL'),
        ),
);

final TeamMateRepositoryProvider = Provider(
        (ref) => TeamMateRepository(
            ref.read(TeamMateServiceProvider),
        ),
);

final TeamMateProvider = StateNotifierProvider<TeamMateNotifier, List<dynamic>>(
        (ref) => TeamMateNotifier(
          ref.read(TeamMateRepositoryProvider),
        ),
);