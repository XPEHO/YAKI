import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';

class DeclarationNotifier extends StateNotifier<dynamic> {
  final DeclarationRepository declarationRepository;

  DeclarationNotifier(this.declarationRepository) : super("");

  /// create the state based on statusMessage & statusImage MAP
  /// from (presentation/displaydata/declaration_card_content.dart
  /// using declaration value as key.
  void setState(String declaration) {
        state = {
          'text': '${statusMessage[declaration]}',
          'image': '${statusImage[declaration]}',
        };
  }

  /// Create a declaration object using declaration string coming from declaration_body widget.
  /// Invoke the setState function
  /// Invoke the repository create method to send the object to the API
  Future<void> create(String declaration) async {
    DeclarationModel newDeclaration = DeclarationModel(
      declaration_date: DateTime.now(),
      declaration_team_mate_id: 1,
      declaration_status: declaration,
    );

    setState(declaration);

    await declarationRepository.create(newDeclaration);
  }
}
