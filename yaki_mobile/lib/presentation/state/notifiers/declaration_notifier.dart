import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/data/repositories/login_repository.dart';

class DeclarationNotifier extends StateNotifier<String> {
  final DeclarationRepository declarationRepository;
  final LoginRepository loginRepository;

  DeclarationNotifier(this.declarationRepository, this.loginRepository)
      : super("");

  Future<String> getDeclaration() async {
    final teamMateId = loginRepository.teamMateId.toString();
    final declarationStatus =
        await declarationRepository.getDeclaration(teamMateId);

    return declarationStatus;
  }

  Future<void> create(String status) async {
    DeclarationModel newDeclaration = DeclarationModel(
      declarationDate: DateTime.now(),
      declarationTeamMateId: loginRepository.teamMateId,
      declarationStatus: status,
    );

    await declarationRepository.create(newDeclaration);
  }
}
