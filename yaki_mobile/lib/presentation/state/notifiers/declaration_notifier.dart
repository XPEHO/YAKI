import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/declaration_model.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';

class DeclarationNotifier extends StateNotifier<dynamic> {
  final DeclarationRepository declarationRepository;

  DeclarationNotifier(this.declarationRepository) : super({
    'isDeclared': false,
    'text': '',
    'image': '',
  });

  /// create the state based on statusMessage & statusImage MAP
  /// from (presentation/displaydata/declaration_card_content.dart
  /// using declaration value as key.
  void setState(String status, bool isDeclared) {
        state = {
          'isDeclared': isDeclared,
          'text': '${statusMessage[status]}',
          'image': '${statusImage[status]}',
        };
  }

  /// Create a declaration object using declaration string coming from declaration_body widget.
  /// Invoke the setState function
  /// Invoke the repository create method to send the object to the API
  Future<void> create(String status) async {
    DeclarationModel newDeclaration = DeclarationModel(
      declaration_date: DateTime.now(),
      declaration_team_mate_id: 1,
      declaration_status: status,
    );

    setState(status, true);

    final statusCreateResponse = await declarationRepository.create(newDeclaration);
    print("test");
    print('print declaratio response ${statusCreateResponse.toJson()}');

  }
}
