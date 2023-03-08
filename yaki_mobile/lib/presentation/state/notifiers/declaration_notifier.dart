import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';

class DeclarationNotifier extends StateNotifier<DeclarationModel> {
  final DeclarationRepository declarationRepository;

  DeclarationNotifier(this.declarationRepository)
      : super(
          DeclarationModel(
            declaration_date: DateTime.now(),
            declaration_team_mate_id: 1,
            declaration_status: "",
          ),
        );

  Future<void> create(String declaration) async {
    DeclarationModel newDeclaration = DeclarationModel(
      declaration_date: DateTime.now(),
      declaration_team_mate_id: 1,
      declaration_status: declaration,
    );
    await declarationRepository.create(newDeclaration);
  }
}
