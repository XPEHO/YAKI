import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

class DeclarationNotifier extends StateNotifier<String> {
  final DeclarationRepository declarationRepository;
  final LoginRepository loginRepository;

  DeclarationNotifier(this.declarationRepository, this.loginRepository)
      : super("");

  /// Invoked at authentication "sign in" button press.
  ///
  /// Get the teammateId from loginRepository getter.
  ///
  /// then invoke the declarationRepository.getDeclaration() method to get the daily declaration, if one was created.
  ///
  /// return the declarationStatus, used in authentication page to determine the redirection.
  Future<String> getDeclaration() async {
    final teamMateId = loginRepository.teamMateId.toString();
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
  /// then invoke the declarationRepository.create(), that will send the newly declaration to the API (via _api.dart)
  Future<void> createAllDay(String status) async {
    final todayDate = DateTime.now();

    DeclarationModel newDeclaration = DeclarationModel(
      declarationDate: todayDate,
      declarationDateStart: DateTime.parse(
        '${parseDate(todayDate)} 00:00:00Z',
      ),
      declarationDateEnd: DateTime.parse(
        '${parseDate(todayDate)} 23:59:59Z',
      ),
      declarationTeamMateId: loginRepository.teamMateId,
      declarationStatus: status,
    );

    await declarationRepository.createAllDay(newDeclaration);
  }

  /// Create declaration for the morning by setting
  /// the dateStart to midnight and dateEnd to noon.
  /// Then send it to declarationRepository's function
  Future<void> createMorning(String status) async {
    final todayDate = DateTime.now();

    DeclarationModel newDeclaration = DeclarationModel(
      declarationDate: todayDate,
      declarationDateStart: DateTime.parse(
        '${parseDate(todayDate)} 00:00:00Z',
      ),
      declarationDateEnd: DateTime.parse(
        '${parseDate(todayDate)} 12:00:00Z',
      ),
      declarationTeamMateId: loginRepository.teamMateId,
      declarationStatus: status,
    );

    await declarationRepository.createAllDay(newDeclaration);
  }

  /// Create declaration for the afternoon by setting
  /// the dateStart to noon and dateEnd to midnight.
  /// Then send it to declarationRepository's function
  Future<void> createAfternoon(String status) async {
    final todayDate = DateTime.now();

    DeclarationModel newDeclaration = DeclarationModel(
      declarationDate: todayDate,
      declarationDateStart: DateTime.parse(
        '${parseDate(todayDate)} 12:00:00Z',
      ),
      declarationDateEnd: DateTime.parse(
        '${parseDate(todayDate)} 23:59:59Z',
      ),
      declarationTeamMateId: loginRepository.teamMateId,
      declarationStatus: status,
    );

    await declarationRepository.createAllDay(newDeclaration);
  }

  /// Take a DateTime and convert it to a string
  /// in the format YYYY-mm-dd
  String parseDate(DateTime date) {
    var result = '${date.year}';
    if (date.month < 10) {
      result += '-0${date.month}';
    }
    if (date.day < 10) {
      result += '-0${date.day}';
    }
    return result;
  }

  setMorningDeclaration(String status) {
    declarationRepository.setMorningDeclaration(status);
  }

  setAfternoonDeclaration(String status) {
    declarationRepository.setAfternoonDeclaration(status);
  }

  String getMorningDeclaration() {
    return declarationRepository.statusMorning;
  }

  DeclarationStatus getAllDeclaration() {
    return declarationRepository.allDeclarations;
  }
}
