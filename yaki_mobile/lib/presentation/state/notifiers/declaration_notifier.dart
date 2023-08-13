import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/data/repositories/team_repository.dart';

class DeclarationNotifier extends StateNotifier<String> {
  final DeclarationRepository declarationRepository;
  final LoginRepository loginRepository;
  final TeamRepository teamRepository;

  DeclarationNotifier(
    this.declarationRepository,
    this.loginRepository,
    this.teamRepository,
  ) : super("");

  /// Invoked at authentication "sign in" button press.
  ///
  /// Get the teammateId from loginRepository getter.
  ///
  /// then invoke the declarationRepository.getDeclaration() method to get the daily declaration, if one was created.
  ///
  /// Return the declarationStatus, used in authentication page to determine the redirection.
  Future<List<String>> getDeclaration() async {
    final teamMateId = loginRepository.userId.toString();
    final declarationStatus =
        await declarationRepository.getDeclaration(teamMateId);
    return declarationStatus;
  }

  /// Invoked in declaration_body "page",
  ///
  /// With the selected status, and the loginRepository.teamMateId getter,
  ///
  /// create a DeclarationModel model instance,
  ///
  /// then invoke the declarationRepository.createAllDay(), that will send the newly declaration to the API (via _api.dart)
  Future<void> createAllDay(String status) async {
    final todayDate = DateTime.now();
    // NEED TO BE CHANGED
    const teamId = 1;
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
    await declarationRepository.createAllDay(newDeclaration);
  }

  /// Create declaration for the morning by setting
  /// the dateStart to midnight and dateEnd to noon.
  /// Then send it to declarationRepository's function
  Future<void> createHalfDay(String morning, String afternoon) async {
    final todayDate = DateTime.now();
    // NEED TO BE CHANGED
    const teamId = 1;
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
  setMorningDeclaration(String status) {
    declarationRepository.setMorningDeclaration(status);
  }

  /// get the morning declaration status stored in declarationRepository
  String getMorningDeclaration() {
    return declarationRepository.statusMorning;
  }

  /// get all declarations stored in declarationRepository
  DeclarationStatus getAllDeclaration() {
    return declarationRepository.allDeclarations;
  }
}
