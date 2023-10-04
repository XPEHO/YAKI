import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/state/state_vacation_page.dart';

class VacationStatusNotifier extends StateNotifier<StateVacationPage> {
  final Ref ref;
  VacationStatusNotifier(this.ref)
      : super(
          StateVacationPage(
            image: 'assets/images/unknown.svg',
            text: '...',
            dateEnd: null,
            dateStart: null,
          ),
        );

  /// set state declaration for the morning
  void setStateVacation(DateTime? dateStart, DateTime? dateEnd) {
    String dateStartString =
        DateFormat.yMd('fr').format(dateStart ?? DateTime.now());
    String dateEndString =
        DateFormat.yMd('fr').format(dateEnd ?? DateTime.now());
    state = StateVacationPage(
      image: 'assets/images/vacation.svg',
      dateStart: dateStartString,
      dateEnd: dateEndString,
      text:
          '${tr('statusVacationDayFrom')}$dateStartString${tr('statusVacationDayTo')}$dateEndString',
    );
  }

  /// Invoked at sign in button press in authentication page.
  ///
  /// And
  ///
  /// Invoked in declaration_body "page".
  ///
  /// Retrieve the status for the day saved in DeclarationStatus entities;
  /// And invoke the "setStateVacation" method.
  void setSelectedStatusVacation() {
    final DeclarationStatus declarationStatus = ref.read(declarationProvider);
    DateTime? fullDateStart = declarationStatus.dateAbsenceStart;
    DateTime? fullDateEnd = declarationStatus.dateAbsenceEnd;
    setStateVacation(fullDateStart, fullDateEnd);
  }
}
