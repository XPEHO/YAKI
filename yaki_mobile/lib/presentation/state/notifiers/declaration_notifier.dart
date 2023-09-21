import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/state/providers/halfday_status_provider.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/state/providers/vacation_status_provider.dart';

class DeclarationNotifier extends StateNotifier<DeclarationStatus> {
  final Ref ref;
  final DeclarationRepository declarationRepository;
  final LoginRepository loginRepository;
  final TeamRepository teamRepository;

  DeclarationNotifier({
    required this.ref,
    required this.declarationRepository,
    required this.loginRepository,
    required this.teamRepository,
  }) : super(DeclarationStatus());

  /// Invoked at authentication "sign in" button press.
  ///
  /// Get the teammateId from loginRepository getter.
  ///
  /// then invoke the declarationRepository.getDeclaration() method to get the daily declaration, if one was created.
  ///
  /// Return the declarationStatus, used in authentication page to determine the redirection.
  Future<List<String>> getLatestDeclaration() async {
    final userId = loginRepository.userId.toString();
    final declarationStatus =
        await declarationRepository.getLatestDeclaration(userId);
    switch (declarationStatus.fullDayStatus.length) {
      case 1:
        if (declarationStatus.fullDayStatus.first == 'vacation') {
          setStateAbsenceStatus(
            dateStart: declarationStatus.dateStart ?? DateTime.now(),
            dateEnd: declarationStatus.dateEnd ?? DateTime.now(),
          );
          setStatusPageVacationContent();
        } else {
          setStateFullDayStatus(status: declarationStatus.fullDayStatus.first);
          setStatusPageFullDayContent();
        }
        break;
      case 2:
        setStateMorningStatus(status: declarationStatus.fullDayStatus.first);
        setStateAfternoonStatus(status: declarationStatus.fullDayStatus.last);
        setStatusPageHalfDayContent();
        break;
      default:
        return declarationStatus.fullDayStatus;
    }
    return declarationStatus.fullDayStatus;
  }

  /// Function invoked in declaration_body, morning_declaration and afternoon_declaration "page"
  ///
  /// this function aim to create declaration based on type of declaration (full day or halfday).
  Future<void> createDeclaration({
    required DeclarationTimeOfDay timeOfDay,
    required String status,
    required int teamId,
  }) async {
    switch (timeOfDay) {
      case DeclarationTimeOfDay.fullDay:
        await createFullDay(
          status: status,
          teamId: teamId,
        );
        break;
      case DeclarationTimeOfDay.morning:
        setStateMorningStatus(status: status);
        break;
      case DeclarationTimeOfDay.afternoon:
        await createHalfDay(
          morning: state.morningStatus,
          afternoon: status,
          teamId: teamId,
        );
        break;
    }
  }

  /// Invoked in declaration_body "page",
  ///
  /// With the selected status, and the loginRepository.teamMateId getter,
  ///
  /// create a DeclarationModel model instance,
  ///
  /// then invoke the declarationRepository.createAllDay(), that will send the newly declaration to the API (via _api.dart)
  Future<void> createFullDay({
    required String status,
    required int teamId,
  }) async {
    final todayDate = DateTime.now();
    DeclarationModel newDeclaration = DeclarationModel(
      declarationUserId: loginRepository.userId,
      declarationDate: todayDate,
      declarationDateStart: DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(todayDate)} 00:00:00Z',
      ),
      declarationDateEnd: DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(todayDate)} 23:59:59Z',
      ),
      declarationTeamId: teamId,
      declarationStatus: status,
    );
    final String fullDayStatus =
        await declarationRepository.createFullDay(newDeclaration);
    //set State
    setStateFullDayStatus(status: fullDayStatus);
    //call the statusProvider to get the latest declaration
    setStatusPageFullDayContent();
  }

  /// Create declaration for the morning by setting
  /// the dateStart to midnight and dateEnd to noon.
  /// Then send it to declarationRepository's function
  Future<void> createHalfDay({
    required morning,
    required String afternoon,
    required int teamId,
  }) async {
    final todayDate = DateTime.now();
    DeclarationModel newDeclarationMorning = DeclarationModel(
      declarationUserId: loginRepository.userId,
      declarationDate: todayDate,
      declarationDateStart: DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(todayDate)} 00:00:00Z',
      ),
      declarationDateEnd: DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(todayDate)} 12:00:00Z',
      ),
      declarationStatus: morning,
      declarationTeamId: teamId,
    );

    DeclarationModel newDeclarationAfternoon = DeclarationModel(
      declarationUserId: loginRepository.userId,
      declarationDate: todayDate,
      declarationDateStart: DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(todayDate)} 13:00:00Z',
      ),
      declarationDateEnd: DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(todayDate)} 23:59:59Z',
      ),
      declarationStatus: afternoon,
      declarationTeamId: teamId,
    );

    List<DeclarationModel> declarations = [
      newDeclarationMorning,
      newDeclarationAfternoon,
    ];
    final List<String> halfDayStatus =
        await declarationRepository.createHalfDay(declarations);
    // set state.
    setStateMorningStatus(status: halfDayStatus.first);
    setStateAfternoonStatus(status: halfDayStatus.last);
    //call the halfdayStatusProvider to get the latest declaration status
    setStatusPageHalfDayContent();
  }

  Future<void> createVacationDeclaration({
    required String status,
    required int teamId,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) async {
    final todayDate = DateTime.now();
    DeclarationModel newDeclaration = DeclarationModel(
      declarationUserId: loginRepository.userId,
      declarationDate: todayDate,
      declarationDateStart: DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(dateStart)} 00:00:00Z',
      ),
      declarationDateEnd: DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(dateEnd)} 23:59:59Z',
      ),
      declarationTeamId: teamId,
      declarationStatus: status,
    );
    await declarationRepository.createFullDay(newDeclaration);
    setStateAbsenceStatus(dateStart: dateStart, dateEnd: dateEnd);
    setStatusPageVacationContent();
  }

  /// Setter for declaration notifier state
  setStateMorningStatus({required String status}) {
    state.morningStatus = status;
  }

  setStateAfternoonStatus({required String status}) {
    state.afternoonStatus = status;
  }

  setStateFullDayStatus({required String status}) {
    state.fullDayStatus = status;
  }

  setStateAbsenceStatus({
    required DateTime dateStart,
    required DateTime dateEnd,
  }) {
    state.dateStart = dateStart;
    state.dateEnd = dateEnd;
  }

  setStatusPageFullDayContent() {
    ref.read(statusPageProvider.notifier).setStatusRecapFullDayContent();
  }

  setStatusPageHalfDayContent() {
    ref.read(halfdayStatusPageProvider.notifier).setStatusRecapHalfDayContent();
  }

  setStatusPageVacationContent() {
    ref.read(vacationStatusPageProvider.notifier).setSelectedStatusVacation();
  }
}
