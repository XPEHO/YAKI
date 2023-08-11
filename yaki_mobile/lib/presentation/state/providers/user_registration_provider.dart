import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/user_registration_repository.dart';
import 'package:yaki/data/sources/remote/user_register_api.dart';

final dioProvider = Provider((ref) => Dio());

final userRegistrationApiProvider = Provider(
  (ref) => UserRegisterApi(
    ref.read(dioProvider),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

final userRegisterRepositoryProvider = Provider(
  (ref) => UserRegistrationRepository(
    ref.read(userRegistrationApiProvider),
  ),
);
