import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/presentation/state/state/state_vacation_page.dart';

class VacationStatusNotifier extends StateNotifier<StateVacationPage> {
  final DeclarationRepository declarationRepository;

  VacationStatusNotifier(this.declarationRepository)
      : super(
          StateVacationPage(
           image: 'assets/images/vacation.svg',
            text: '...',
          ),
        );

  /// set state declaration for the morning
  void setStateVacation(String dateStart, String dateEnd) {
    state = StateVacationPage(
      image: 'assets/images/vacation.svg',
      text: tr('statusVacationDayFrom') + '$dateStart' + tr('statusVacationDayTo') + '$dateEnd',
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
  void getSelectedStatus(String dateStart, String dateEnd){
    setStateVacation(dateStart, dateEnd);
  }
}
