import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';

class DeclarationNotifier extends StateNotifier<String> {
  final DeclarationRepository declarationRepository;
  final LoginRepository loginRepository;

  DeclarationNotifier(this.declarationRepository, this.loginRepository)
      : super("");

  /// Invoked at authentication "sign in" button press.
  ///
  /// Get the teammateId from loginRepository getter.
  ///
  /// then invoke the declarationRepository.getDeclaration() method to get the daily declaration, if one was set.
  ///
  /// return the declarationStatus, used in authentication page to determine the redirection.
  Future<String> getDeclaration() async {
    final teamMateId = loginRepository.teamMateId.toString();
    final declarationStatus =
        await declarationRepository.getDeclaration(teamMateId);

    return declarationStatus;
  }

  /// invoked in declaration_body "page",
  ///
  /// With the selected status, and the loginRepository.teamMateId getter,
  ///
  /// create a DeclarationModel model instance,
  ///
  /// then invoke the declarationRepository.create(), that will send the newly declaration to the API (via _api.dart)
  Future<void> create(String status) async {
    DeclarationModel newDeclaration = DeclarationModel(
      declarationDate: DateTime.now(),
      declarationTeamMateId: loginRepository.teamMateId,
      declarationStatus: status,
    );

    await declarationRepository.create(newDeclaration);
  }
}
