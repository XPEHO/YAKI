import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';

class DeclarationNotifier extends StateNotifier<DeclarationStatus> {
  final DeclarationRepository declarationRepository;

  DeclarationNotifier({
    required this.declarationRepository,
  }) : super(DeclarationStatus());

  /// Invoked at authentication "sign in" button press.
  Future<List<String>> getLatestDeclaration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");

    if (userId == null) return [];

    final declarationStatus =
        await declarationRepository.getLatestDeclaration(userId);
    switch (declarationStatus.fullDayStatus.length) {
      case 1:
        if (declarationStatus.fullDayStatus.first == 'vacation') {
          setStateAbsenceStatus(
            dateStart: declarationStatus.dateStart ?? DateTime.now(),
            dateEnd: declarationStatus.dateEnd ?? DateTime.now(),
          );
        } else {
          // need to be be reworked
          // need to set value to state.fullDayStatus
        }
        break;
      case 2:
        // need to be be reworked
        // need to set values to state.teamsHalfDay.firstTeamStatus & state.teamsHalfDay.secondTeamStatus
        break;
      default:
        return declarationStatus.fullDayStatus;
    }
    return declarationStatus.fullDayStatus;
  }

  /// Function invoked in declaration page when a card is selected.
  Future<void> declarationCreationHandler({
    required DeclarationPaths declarationMode,
    required List<TeamModel> teamList,
    required StatusEnum selectedStatus,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");

    // exit function if improper data
    if (userId == null ||
        teamList.first.teamId == null ||
        teamList.last.teamId == null) return;

    switch (declarationMode) {
      // FULL DAY
      case DeclarationPaths.fullDay:
        state.fullDayTeam = teamList.first;
        state.fullDayStatus = selectedStatus;

        await createFullDay(
          status: StatusEnum.getValue(key: selectedStatus.name),
          teamId: teamList.first.teamId!,
          userId: userId,
        );
        break;

      // TIME OF DAY determine initial morning or afternoon selection
      case DeclarationPaths.timeOfDay:
        state.teamsHalfDay.firstToDSelection = selectedStatus;
        state.teamsHalfDay.firstTeam = teamList.first;
        state.teamsHalfDay.secondTeam = teamList.last;

        // declaration requier a teamID,
        // therefore in case of ABSENCE for now will use the second teamID,
        // as the DB declaration table requier a valid teamId.
        if (state.teamsHalfDay.firstTeam.teamId == -1) {
          state.teamsHalfDay.firstStatus = StatusEnum.absence;
          state.teamsHalfDay.firstTeam = teamList.last;
        }
        break;

      // HALF DAY START determine first team status (remote / on site)
      case DeclarationPaths.halfDayStart:
        state.teamsHalfDay.firstStatus = selectedStatus;
        break;

      // HALF DAY END determine second team status (remote / on site ), and create the declaration
      case DeclarationPaths.halfDayEnd:
        state.teamsHalfDay.secondStatus = selectedStatus;

        if (state.teamsHalfDay.firstToDSelection == StatusEnum.morning) {
          await createHalfDay(
            morningStatus: StatusEnum.getValue(
              key: state.teamsHalfDay.firstStatus.name,
            ),
            morningTeamId: state.teamsHalfDay.firstTeam.teamId!,
            afternoonStatus: StatusEnum.getValue(
              key: state.teamsHalfDay.secondStatus.name,
            ),
            afternoonTeamId: state.teamsHalfDay.secondTeam.teamId!,
            userId: userId,
          );
        } else {
          await createHalfDay(
            morningStatus: StatusEnum.getValue(
              key: state.teamsHalfDay.secondStatus.name,
            ),
            morningTeamId: state.teamsHalfDay.secondTeam.teamId!,
            afternoonStatus: StatusEnum.getValue(
              key: state.teamsHalfDay.firstStatus.name,
            ),
            afternoonTeamId: state.teamsHalfDay.firstTeam.teamId!,
            userId: userId,
          );
        }
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

    // NEED TO BE CHANGED
    setStateAbsenceStatus(dateStart: dateStart, dateEnd: dateEnd);
  }

  setStateAbsenceStatus({
    required DateTime dateStart,
    required DateTime dateEnd,
  }) {
    state.dateStart = dateStart;
    state.dateEnd = dateEnd;
  }
}
