import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/state/state_teammate_page.dart';

class TeammateNotifier extends StateNotifier<StateTeamMate> {
  TeammateNotifier()
      : super(
          StateTeamMate(
            fetchedTeammateList: [],
            selectedTeammateList: [],
          ),
        );
}
