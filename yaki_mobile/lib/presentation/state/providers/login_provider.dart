import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/data/sources/login_api.dart';
import 'package:yaki/presentation/state/login_state.dart';
import 'package:yaki/presentation/state/notifiers/login_notifier.dart';
import 'package:dio/dio.dart';

import '../../../data/models/login.dart';

final dioProvider = Provider((ref) => Dio());

final loginServiceProvider = Provider(
  (ref) => LoginService(
    ref.read(
      dioProvider,
    ),
  ),
);

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(ref.read(loginServiceProvider)),
);

final loginProvider = StateNotifierProvider<LoginNotifier, Login>(
  (ref) => LoginNotifier(
    ref.read(
      loginRepositoryProvider,
    ),
  ),
);
