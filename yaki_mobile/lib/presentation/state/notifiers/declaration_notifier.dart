import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/data/repositories/team_repository.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';

class DeclarationNotifier extends StateNotifier<void> {
  final DeclarationRepository declarationRepository;
  final LoginRepository loginRepository;
  final TeamRepository teamRepository;

  DeclarationNotifier(
    this.declarationRepository,
    this.loginRepository,
    this.teamRepository,
  ) : super(0);

  /// Invoked at authentication "sign in" button press.
  ///
  /// Get the teammateId from loginRepository getter.
  ///
  /// then invoke the declarationRepository.getDeclaration() method to get the daily declaration, if one was created.
  ///
  /// Return the declarationStatus, used in authentication page to determine the redirection.
  Future<List<String>> getLatestDeclaration() async {
    final teamMateId = loginRepository.userId.toString();
    final declarationStatus =
        await declarationRepository.getLatestDeclaration(teamMateId);
    return declarationStatus;
  }

  /// Function invoked in declaration_body, morning_declaration and afternoon_declaration "page"
  ///
  /// this function aim to create declaration based on type of declaration (full day or halfday).
  void createDeclaration({
    required DeclarationTimeOfDay timeOfDay,
    required String status,
    required int teamId,
  }) {
    switch (timeOfDay) {
      case DeclarationTimeOfDay.morning:
        setMorningStatus(status);
        break;
      case DeclarationTimeOfDay.afternoon:
        createHalfDay(
          morning: declarationRepository.statusMorning,
          afternoon: status,
          teamId: teamId,
        );
        break;
      case DeclarationTimeOfDay.fullDay:
        createFullDay(
          status: status,
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
    await declarationRepository.createFullDay(newDeclaration);
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
      newDeclarationAfternoon
    ];

    await declarationRepository.createHalfDay(declarations);
  }

  /// set the morning declaration status stored in declarationRepository
  setMorningStatus(String status) {
    declarationRepository.setMorningStatus(status);
  }

  /// get the morning declaration status stored in declarationRepository
  String getMorningStatus() {
    return declarationRepository.statusMorning;
  }

  /// get all declarations stored in declarationRepository
  DeclarationStatus getAllStatus() {
    return declarationRepository.allDeclarations;
  }
}
