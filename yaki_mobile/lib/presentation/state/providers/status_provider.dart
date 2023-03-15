import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/notifiers/status_notifier.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/state/state_status_page.dart';

final statusPageProvider =
    StateNotifierProvider<StatusPageNotifier, StateStatusPage>(
  (ref) => StatusPageNotifier(
    ref.read(declarationRepositoryProvider),
  ),
);
