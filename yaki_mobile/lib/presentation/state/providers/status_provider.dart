import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/notifiers/status_notifier.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';

final statusPageProvider = StateNotifierProvider<StatusPageNotifier, StateStatus>(
  (ref) => StatusPageNotifier(
    ref.read(declarationRepositoryProvider),
  ),
);
