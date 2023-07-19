import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/user_registration_service.dart';
import 'package:yaki/data/sources/remote/user_register_repository.dart';

final dioProvider = Provider((ref) => Dio());

final userRegistrationRepositoryProvider = Provider(
  (ref) => UserRegisterRepository(
    ref.read(dioProvider),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

final userRegisterServiceProvider = Provider(
  (ref) => UserRegistrationService(
    ref.read(userRegistrationRepositoryProvider),
  ),
);
