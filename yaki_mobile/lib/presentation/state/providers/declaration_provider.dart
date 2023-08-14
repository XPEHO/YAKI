import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/sources/remote/declaration_api.dart';
import 'package:yaki/presentation/state/notifiers/declaration_notifier.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';

/// Create a provider of the DeclarationApi, allowing riverpod to know about values changes.
/// As its the only access point, its a singleton
///
/// At instantiation, inject the custom dioInterceptor to add custom behavior at every *_api.dart request.
final declarationApiProvider = Provider(
  (ref) => DeclarationApi(
    ref.read(dioInterceptor),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

/// Create a provider of DeclarationRepository, allowing riverpod to know about values changes.
/// As its the only access point, its a singleton
///
/// At DeclarationRepository instantiation inject the declarationApiProvider.
///
/// As DeclarationRepository use instance of DeclarationApi to access his methods.
final declarationRepositoryProvider = Provider(
  (ref) => DeclarationRepository(
    ref.read(declarationApiProvider),
  ),
);

/// Create a provider of DeclarationNotifier, allowing riverpod to know about values changes.
/// As its the only access point, its a singleton
///
/// StateNotifier is a state management class,
/// and StateNotifierProvider is a provider that is used to listen to and expose a StateNotifier.
/// allow to manipulate state.
///
/// At DeclarationNotifier instantiation, declarationRepositoryProvider and loginRepositoryProvider are injected.
///
/// This provider make accessible repository and routes related to status declaration.
/// Notifier methods are related to the declaration page.
final declarationProvider = StateNotifierProvider<DeclarationNotifier, void>(
  (ref) => DeclarationNotifier(
    ref: ref,
    declarationRepository: ref.read(declarationRepositoryProvider),
    loginRepository: ref.read(loginRepositoryProvider),
    teamRepository: ref.read(teamRepositoryProvider),
  ),
);
