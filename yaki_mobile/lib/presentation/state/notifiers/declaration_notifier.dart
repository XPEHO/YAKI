import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/state/providers/halfday_status_provider.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/state/providers/vacation_status_provider.dart';

class DeclarationNotifier extends StateNotifier<DeclarationStatus> {
  final Ref ref;
  final DeclarationRepository declarationRepository;
  final LoginRepository loginRepository;

  DeclarationNotifier({
    required this.ref,
    required this.declarationRepository,
    required this.loginRepository,
  }) : super(DeclarationStatus());

  /// Invoked at authentication "sign in" button press.
  Future<List<String>> getLatestDeclaration() async {
    final userId = loginRepository.userId;
    final declarationStatus =
        await declarationRepository.getLatestDeclaration(userId!);
    switch (declarationStatus.fullDayStatus.length) {
      case 1:
        if (declarationStatus.fullDayStatus.first == 'vacation') {
          setStateAbsenceStatus(
            dateStart: declarationStatus.dateStart ?? DateTime.now(),
            dateEnd: declarationStatus.dateEnd ?? DateTime.now(),
          );
          setStatusPageVacationContent();
        } else {
          state.fullDayStatus = declarationStatus.fullDayStatus.first;
          setStatusPageFullDayContent();
        }
        break;
      case 2:
        state.morningStatus = declarationStatus.fullDayStatus.first;
        state.afternoonStatus = declarationStatus.fullDayStatus.last;
        setStatusPageHalfDayContent();
        break;
      default:
        return declarationStatus.fullDayStatus;
    }
    return declarationStatus.fullDayStatus;
  }

  // BASTIUI CODE =====================================================================================

  Future<void> declarationCreationHandler() async {}

  // PREVIEW CODE =====================================================================================
  // =================================================================================================

  /// Function invoked in declaration_body, morning_declaration and afternoon_declaration "page"
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
        state.morningStatus = status;
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
  Future<void> createFullDay({
    required String status,
    required int teamId,
  }) async {
    final todayDate = DateTime.now();

    // CREATE DECLARATION
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
    // SEND TO REPOSITORY
    final String fullDayStatus =
        await declarationRepository.createFullDay(newDeclaration);

    //SET STATE
    state.fullDayStatus = fullDayStatus;

    // NEED TO BE CHANGED
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
    // FIRST DECLARATION
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
    // SECOND DECLARATION
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

    // ADD THE 2 DECLARATION TO THE LIST
    List<DeclarationModel> declarations = [
      newDeclarationMorning,
      newDeclarationAfternoon,
    ];
    final List<String> halfDayStatus =
        await declarationRepository.createHalfDay(declarations);

    // SET STATE.
    state.morningStatus = halfDayStatus.first;
    state.afternoonStatus = halfDayStatus.last;

    // NEED TO BE CHANGED
    setStatusPageHalfDayContent();
  }

  Future<void> createVacationDeclaration({
    required String status,
    required int teamId,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) async {
    final todayDate = DateTime.now();

    // CREATE DECLARATION
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

    // SEND TO REPOSITORY
    await declarationRepository.createFullDay(newDeclaration);

    // NEED TO BE CHANGED
    setStateAbsenceStatus(dateStart: dateStart, dateEnd: dateEnd);
    setStatusPageVacationContent();
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
