import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/notifiers/halfday_status_notifier.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/state/state_halfday_page.dart';

final halfdayStatusPageProvider =
    StateNotifierProvider<HalfdayStatusNotifier, StateHalfdayPage>(
  (ref) => HalfdayStatusNotifier(
    ref.read(declarationRepositoryProvider),
  ),
);
