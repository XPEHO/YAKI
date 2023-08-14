import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/notifiers/vacation_status_notifier.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/state/state_vacation_page.dart';

final vacationStatusPageProvider =
    StateNotifierProvider<VacationStatusNotifier, StateVacationPage>(
  (ref) => VacationStatusNotifier(
    ref.read(declarationRepositoryProvider),
  ),
);