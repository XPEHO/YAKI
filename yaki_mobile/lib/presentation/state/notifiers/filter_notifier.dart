import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/filter_entity.dart';

class FilterNotifier extends StateNotifier<FilterEntity> {
  FilterNotifier() : super(FilterEntity(selectedTeams: []));

  void setFilter(FilterEntity filter) {
    state = filter;
  }

  void addTeam(int teamId) {
    state = FilterEntity(
      selectedTeams: [...state.selectedTeams, teamId],
    );
  }

  void removeTeam(int teamId) {
    state = FilterEntity(
      selectedTeams: state.selectedTeams..remove(teamId),
    );
  }
}
