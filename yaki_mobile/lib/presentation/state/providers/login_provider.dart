import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/data/sources/remote/login_api.dart';
import 'package:yaki/presentation/state/notifiers/login_notifier.dart';

final dioProvider = Provider((ref) => Dio());

final loginServiceProvider = Provider(
  (ref) => LoginApi(
    ref.read(
      dioProvider,
    ),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(ref.read(loginServiceProvider)),
);

final loginProvider = StateNotifierProvider<LoginNotifier, int>(
  (ref) => LoginNotifier(
    ref.read(
      loginRepositoryProvider,
    ),
  ),
);
