import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/teammate_repository.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';

class TeammateNotifier
    extends StateNotifier<List<TeammateWithDeclarationEntity>> {
  final TeammateRepository teammateRepository;

  TeammateNotifier(this.teammateRepository)
      : super(
          [],
        );

  /// Retrieve the information from the team_mate_repository and store it in the state
  Future<void> fetchTeammates() async {
    final teamList = await teammateRepository.getTeammate();
    state = teamList;
  }
}
