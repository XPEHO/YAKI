import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

class DeclarationNotifier extends StateNotifier<DeclarationStatus> {
  final DeclarationRepository declarationRepository;
  final TeamRepository teamRepository;

  DeclarationNotifier({
    required this.declarationRepository,
    required this.teamRepository,
  }) : super(DeclarationStatus()) {
    getLatestDeclaration();
  }

  /// Invoked at authentication "sign in" button press.
  Future<void> getLatestDeclaration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");

    if (userId == null) {
      state = state.copyWith(
        latestDeclarationStatus: LatestDeclarationStatus.notDeclared,
      );
    } else {
      final bool isAlreadyDeclared =
          await declarationRepository.getLatestDeclaration(userId);

      state = state.copyWith(
        latestDeclarationStatus: isAlreadyDeclared
            ? LatestDeclarationStatus.declared
            : LatestDeclarationStatus.notDeclared,
      );
    }
  }

  /// Function invoked in declaration page when a locationCard is selected.
  /// Handle the creation of the declaration. FullDay or HalfDay.
  ///
  /// HalfDay is split in 3 steps,
  /// * Time Of Day :  morning and afternoon selection while determining if an absence is selected (If so go to last halfDay declaration step).
  /// * First halfDay step : save the first selected status (remote / on site).
  /// * last halfDay step : save the second selected status (remote / on site).
  Future<void> declarationCreationHandler({
    required DeclarationPaths declarationMode,
    required List<TeamModel> teamList,
    required StatusEnum selectedStatus,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");

    // exit function if improper data
    if (userId == null) return;

    switch (declarationMode) {
      case DeclarationPaths.fullDay:
        handleStateAndFullDayDeclaration(teamList, selectedStatus, userId);
        break;
      case DeclarationPaths.timeOfDay:
        handleTimeOfDayDeclaration(teamList, selectedStatus);
        break;
      case DeclarationPaths.halfDayStart:
        handleHalfDayStartDeclaration(selectedStatus);
        break;
      case DeclarationPaths.halfDayEnd:
        await handleHalfDayEndDeclaration(teamList, selectedStatus, userId);
        break;
      default:
        debugPrint('improper declaration mode');
        break;
    }
  }

  /// set fullDayTeam and fullDayStatus in state
  /// then create the fullDay declaration
  Future<void> handleStateAndFullDayDeclaration(
    List<TeamModel> teamList,
    StatusEnum selectedStatus,
    int userId,
  ) async {
    state.fullDayTeam = teamList.first;
    state.fullDayStatus = selectedStatus;

    await createFullDay(
      status: StatusEnum.getValue(key: selectedStatus.name),
      teamId: teamList.first.teamId,
      userId: userId,
    );
  }

  /// First part of the halfDay declaration: Time of day selection for the first team.
  /// Set in state :
  /// * First, and second team (order determined by user selection order).
  /// * Time of day selection (morning or afternoon), related to the first team.
  /// * IF the first team is "absence", register the status
  /// (as absence as no  team, assign the team to be associatd with the absence)
  void handleTimeOfDayDeclaration(
    List<TeamModel> teamList,
    StatusEnum selectedStatus,
  ) {
    state.halfDayWorkflow.firstToDSelection = selectedStatus;
    state.halfDayWorkflow.firstTeam = teamList.first;
    state.halfDayWorkflow.secondTeam = teamList.last;

    if (state.halfDayWorkflow.firstTeam.teamId == -1) {
      state.halfDayWorkflow.firstStatus = StatusEnum.absence;
      state.halfDayWorkflow.firstTeam = teamList.last;
    }
  }

  /// Second part of the halfDay declaration: **WHERE** (remote / on site) for the first team.
  /// register the status in state.
  void handleHalfDayStartDeclaration(StatusEnum selectedStatus) {
    state.halfDayWorkflow.firstStatus = selectedStatus;
  }

  /// Last part of the halfDay declaration: **WHERE** (remote / on site) for the second team.
  /// Save the second status in state, then invoke the create halfDay declaration function.
  Future<void> handleHalfDayEndDeclaration(
    List<TeamModel> teamList,
    StatusEnum selectedStatus,
    int userId,
  ) async {
    state.halfDayWorkflow.secondStatus = selectedStatus;

    setDeclarationHalfDaySelection();

    await createHalfDay(
      morningStatus: StatusEnum.getValue(
        key: state.declarationsHalfDaySelections.morningTeamStatus.name,
      ),
      morningTeamId: state.declarationsHalfDaySelections.morningTeam.teamId,
      afternoonStatus: StatusEnum.getValue(
        key: state.declarationsHalfDaySelections.afternoonTeamStatus.name,
      ),
      afternoonTeamId: state.declarationsHalfDaySelections.afternoonTeam.teamId,
      userId: userId,
    );
  }

  /// Create fullday declaration Model to be send to the repository
  Future<void> createFullDay({
    required String status,
    required int teamId,
    required int userId,
  }) async {
    final todayDate = DateTime.now().toUtc();

    // CREATE DECLARATION
    DeclarationModel newDeclaration = DeclarationModel(
      declarationUserId: userId,
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
    await declarationRepository.createFullDay(newDeclaration);
    state = state.copyWith(
      latestDeclarationStatus: LatestDeclarationStatus.declared,
    );
  }

  /// Create declaration for the morning by setting
  /// the dateStart to midnight and dateEnd to noon.
  /// Then send it to declarationRepository's function
  Future<void> createHalfDay({
    required String morningStatus,
    required int morningTeamId,
    required String afternoonStatus,
    required int afternoonTeamId,
    required int userId,
  }) async {
    final todayDate = DateTime.now().toUtc();
    // FIRST DECLARATION
    DeclarationModel newDeclarationMorning = DeclarationModel(
      declarationUserId: userId,
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
      declarationUserId: userId,
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
    await declarationRepository.createHalfDay(declarations);
    state = state.copyWith(
      latestDeclarationStatus: LatestDeclarationStatus.declared,
    );
  }

  /// ABSENCE declaration Model creation
  Future<void> createAbsenceDeclaration({
    required String status,
    required int teamId,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) async {
    final todayDate = DateTime.now().toUtc();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");

    // CREATE DECLARATION
    DeclarationModel newDeclaration = DeclarationModel(
      declarationUserId: userId ?? 0,
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

    state = state.copyWith(
      dateAbsenceStart: dateStart,
      dateAbsenceEnd: dateEnd,
      latestDeclarationStatus: LatestDeclarationStatus.declared,
    );
  }

  /// Depending of the informations registered during the halfDay declaration process.
  /// (use the TimeOfDay selected for the first team)
  /// Determine the team and status of the morning and afternoon declaration.
  setDeclarationHalfDaySelection() {
    final HalfDayWorkflow workflow = state.halfDayWorkflow;

    workflow.firstToDSelection == StatusEnum.morning
        ? state.declarationsHalfDaySelections = DeclarationsHalfDaySelections(
            morningTeam: workflow.firstTeam,
            morningTeamStatus: workflow.firstStatus,
            afternoonTeam: workflow.secondTeam,
            afternoonTeamStatus: workflow.secondStatus,
          )
        : state.declarationsHalfDaySelections = DeclarationsHalfDaySelections(
            morningTeam: workflow.secondTeam,
            morningTeamStatus: workflow.secondStatus,
            afternoonTeam: workflow.firstTeam,
            afternoonTeamStatus: workflow.firstStatus,
          );
  }
}
