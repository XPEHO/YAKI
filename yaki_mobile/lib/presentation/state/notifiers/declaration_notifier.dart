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
  }) : super(DeclarationStatus());

  /// Invoked at authentication "sign in" button press.
  Future<bool> getLatestDeclaration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");

    if (userId == null) {
      state = state.copyWith(isAlreadyDeclared: false);
      return false;
    }

    final bool isAlreadyDeclared =
        await declarationRepository.getLatestDeclaration(userId);

    state = state.copyWith(isAlreadyDeclared: isAlreadyDeclared);
    return isAlreadyDeclared;
  }

  /// Function invoked in declaration page when a locationCard is selected.
  /// Handle the creation of the declaration. FullDay or HalfDay.
  ///
  /// HalfDay is split in 3 steps, morning and afternoon selection while determining if an absence is selected (If so to to last halfDay declaration step).
  ///
  /// Then the first halfDay step : save the first selected status (remote / on site).
  /// The last halfDay step : save the second selected status (remote / on site), set the DeclarationHalfDaySelection and create the declaration.
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
      // FULL DAY
      case DeclarationPaths.fullDay:
        state.fullDayTeam = teamList.first;
        state.fullDayStatus = selectedStatus;

        await createFullDay(
          status: StatusEnum.getValue(key: selectedStatus.name),
          teamId: teamList.first.teamId,
          userId: userId,
        );
        break;

      // TIME OF DAY determine initial morning or afternoon selection
      case DeclarationPaths.timeOfDay:
        state.halfDayWorkflow.firstToDSelection = selectedStatus;
        state.halfDayWorkflow.firstTeam = teamList.first;
        state.halfDayWorkflow.secondTeam = teamList.last;

        // declaration requier a teamID,
        // therefore in case of ABSENCE for now will use the second teamID,
        // as the DB declaration table requier a valid teamId.
        if (state.halfDayWorkflow.firstTeam.teamId == -1) {
          state.halfDayWorkflow.firstStatus = StatusEnum.absence;
          state.halfDayWorkflow.firstTeam = teamList.last;
        }
        break;

      // HALF DAY START determine first team status (remote / on site)
      case DeclarationPaths.halfDayStart:
        state.halfDayWorkflow.firstStatus = selectedStatus;
        break;

      // HALF DAY END determine second team status (remote / on site ), and create the declaration
      case DeclarationPaths.halfDayEnd:
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
          afternoonTeamId:
              state.declarationsHalfDaySelections.afternoonTeam.teamId,
          userId: userId,
        );
        break;
      default:
        debugPrint('improper declaration mode');
        break;
    }
  }

  /// Invoked in declaration_body "page",
  Future<void> createFullDay({
    required String status,
    required int teamId,
    required int userId,
  }) async {
    final todayDate = DateTime.now();

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
    state = state.copyWith(isAlreadyDeclared: true);
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
    final todayDate = DateTime.now();
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
    state = state.copyWith(isAlreadyDeclared: true);
  }

  // ABSENCE declaration creation.
  Future<void> createVacationDeclaration({
    required String status,
    required int teamId,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) async {
    final todayDate = DateTime.now();

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
      isAlreadyDeclared: true,
    );
  }

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
