import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/notifiers/status_notifier.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/state/state_status_page.dart';

/// Create a provider of StatusPageNotifier, allowing riverpod to know about values changes.
/// As its the only access point, its a singleton
///
/// StateNotifier is a state management class,
/// and StateNotifierProvider is a provider that is used to listen to and expose a StateNotifier.
/// allow to manipulate state.
///
/// This provider make accessible repository related to status declaration, notifier methode are related to the selected status resume page.
final statusPageProvider =
    StateNotifierProvider<StatusPageNotifier, StateStatusPage>(
  (ref) => StatusPageNotifier(
    ref.read(declarationRepositoryProvider),
  ),
);
