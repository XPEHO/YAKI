import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/data/sources/remote/login_api.dart';

/// Creation of a provider of Dio
/// Dio is a flutter http client,
final dioProvider = Provider((ref) => Dio());

/// Create a provider of the LoginApi, allowing riverpod to know about values changes.
/// As its the only access point, its a singleton
///
/// At instantiation, inject dioProvider.
final loginApiProvider = Provider(
  (ref) => LoginApi(
    ref.read(
      dioProvider,
    ),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

/// Create a provider of LoginRepository, allowing riverpod to know about values changes.
/// As its the only access point, its a singleton
///
/// At LoginRepository instantiation inject the loginApiProvider.
///
/// As LoginRepository use instance of LoginApi to access his methods.
final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(ref.read(loginApiProvider)),
);
