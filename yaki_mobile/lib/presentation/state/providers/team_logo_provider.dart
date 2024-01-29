import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/team_logo_repository.dart';
import 'package:yaki/data/sources/remote/team_logo_api.dart';
import 'package:yaki/domain/entities/team_logo_entity.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/notifiers/team_logo_notifier.dart';
import 'package:yaki/presentation/state/providers/url_provider.dart';

final teamLogoApi = Provider(
  (ref) => TeamLogoApi(
    ref.read(dioInterceptor),
    baseUrl: ref.read(urlProvider),
  ),
);

final teamLogoRepository = Provider(
  (red) => TeamLogoRepository(
    red.read(teamLogoApi),
  ),
);

final teamLogoProvider =
    StateNotifierProvider<TeamLogoNotifier, List<TeamLogoEntity>>(
  (ref) => TeamLogoNotifier(
    teamLogoRepository: ref.read(teamLogoRepository),
  ),
);
