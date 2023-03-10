import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';

class DeclarationNotifier extends StateNotifier<DeclarationModel> {
  final DeclarationRepository declarationRepository;

  DeclarationNotifier(this.declarationRepository)
      : super(
          DeclarationModel(
            declarationDate: DateTime.now(),
            declarationTeamMateId: 1,
            declarationStatus: "",
          ),
        );

  Future<void> create(String declaration) async {
    DeclarationModel newDeclaration = DeclarationModel(
      declarationDate: DateTime.now(),
      declarationTeamMateId: 1,
      declarationStatus: declaration,
    );
    await declarationRepository.create(newDeclaration);
  }
}
