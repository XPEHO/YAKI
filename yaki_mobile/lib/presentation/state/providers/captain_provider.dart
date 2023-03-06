import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/captain_model.dart';
import 'package:yaki/data/repositories/captain_repository.dart';

import 'package:yaki/data/sources/captain_api.dart';
import 'package:yaki/presentation/state/notifiers/captain_notifier.dart';

final dioProvider = Provider((ref) => Dio());

final captainServiceProvider = Provider(
  (ref) => CaptainApi(
    ref.read(
      dioProvider,
    ),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

final captainRepositoryProvider = Provider<CaptainRepository>(
        (ref) => CaptainRepository(ref.read(captainServiceProvider),
        ),
);

final captainProvider = StateNotifierProvider<CaptainNotifier, CaptainModel>(
        (ref) => CaptainNotifier(
          ref.read(
              captainRepositoryProvider,
          ),
        ),
);