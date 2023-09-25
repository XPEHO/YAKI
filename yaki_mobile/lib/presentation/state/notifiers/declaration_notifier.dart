import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
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

  // WILL NEED TO BE REVIEWED AFTER DECLARATION LOGIC REWORK WITH BASTI DESIGN
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
        // state.morningStatus = declarationStatus.fullDayStatus.first;
        //state.afternoonStatus = declarationStatus.fullDayStatus.last;
        state.fullDayStatus = declarationStatus.fullDayStatus.first;
        state.fullDayStatus = declarationStatus.fullDayStatus.last;
        setStatusPageHalfDayContent();
        break;
      default:
        return declarationStatus.fullDayStatus;
    }
    return declarationStatus.fullDayStatus;
  }

  // BASTIUI CODE =====================================================================================

  /// Function invoked in declaration page when a card is selected.
  Future<void> declarationCreationHandler({
    required DeclarationPaths declarationMode,
    required List<TeamModel> teamList,
    required StatusEnum selectedStatus,
  }) async {
    switch (declarationMode) {
      // FULL DAY
      case DeclarationPaths.fullDay:
        await createFullDay(
          status: StatusEnum.getValue(key: selectedStatus.name),
          teamId: teamList.first.teamId ?? 0,
        );
        break;
      // HALF DAY determine first team morning or afternoon
      case DeclarationPaths.timeOfDay:
        state.teamsHalfDay.firstToDSelection = selectedStatus;
        state.teamsHalfDay.firstTeamId = teamList.first.teamId ?? 0;
        state.teamsHalfDay.secondTeamId = teamList.last.teamId ?? 0;

        // declaration requier a teamID,
        //therefore for now will set the second teamID, as the DB declaration table requier a valid teamId
        if (state.teamsHalfDay.firstTeamId == -1) {
          state.teamsHalfDay.firstTeamStatus = StatusEnum.absence.name;
          state.teamsHalfDay.firstTeamId = teamList.last.teamId!;
        }
        break;
      // HALF DAY determine first team status (remote / on site )
      case DeclarationPaths.halfDayStart:
        state.teamsHalfDay.firstTeamStatus =
            StatusEnum.getValue(key: selectedStatus.name);
        break;
      // HALF DAY determine second team status (remote / on site ), and create the declaration
      case DeclarationPaths.halfDayEnd:
        state.teamsHalfDay.secondTeamStatus =
            StatusEnum.getValue(key: selectedStatus.name);

        if (state.teamsHalfDay.firstToDSelection == StatusEnum.morning) {
          await createHalfDay(
            morningStatus: state.teamsHalfDay.firstTeamStatus,
            morningTeamId: state.teamsHalfDay.firstTeamId,
            afternoonStatus: state.teamsHalfDay.secondTeamStatus,
            afternoonTeamId: state.teamsHalfDay.secondTeamId,
          );
        } else {
          await createHalfDay(
            morningStatus: state.teamsHalfDay.secondTeamStatus,
            morningTeamId: state.teamsHalfDay.secondTeamId,
            afternoonStatus: state.teamsHalfDay.firstTeamStatus,
            afternoonTeamId: state.teamsHalfDay.firstTeamId,
          );
        }
        break;
      //
      case DeclarationPaths.vacation:
      //
      default:
      //
    }
  }

  // TO KEEP AFTER TRANSITION TO BASTIU REDESIGN
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
    required String morningStatus,
    required int morningTeamId,
    required String afternoonStatus,
    required int afternoonTeamId,
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
      declarationStatus: morningStatus,
      declarationTeamId: morningTeamId,
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
      declarationStatus: afternoonStatus,
      declarationTeamId: afternoonTeamId,
    );

    // ADD THE 2 DECLARATION TO THE LIST
    List<DeclarationModel> declarations = [
      newDeclarationMorning,
      newDeclarationAfternoon,
    ];
    final List<String> halfDayStatus =
        await declarationRepository.createHalfDay(declarations);

    // SET STATE.
    //state.morningStatus = halfDayStatus.first;
    //state.afternoonStatus = halfDayStatus.last;
    state.fullDayStatus = halfDayStatus.first;
    state.fullDayStatus = halfDayStatus.last;

    // NEED TO BE CHANGED
    setStatusPageHalfDayContent();
  }

  // ABSENCE declaration creation.
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

  // THIS WILL NEED TO BE REVIEW AND CHANGED with proper provider abonment
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
