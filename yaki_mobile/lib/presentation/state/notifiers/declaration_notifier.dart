import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';

class DeclarationNotifier extends StateNotifier<String> {
  final DeclarationRepository declarationRepository;

  DeclarationNotifier(this.declarationRepository) : super("");

  Future<int?> create(String status) async {
    DeclarationModel newDeclaration = DeclarationModel(
      declaration_date: DateTime.now(),
      declaration_team_mate_id: 1,
      declaration_status: status,
    );

   return declarationRepository.create(newDeclaration);
  }
}
