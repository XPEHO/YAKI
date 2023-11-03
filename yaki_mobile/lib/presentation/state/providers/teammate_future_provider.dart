import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/grouped_users_with_declaration.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/displaydata/user_with_declaration_category_enum.dart';
import 'package:yaki/presentation/state/providers/filter_provider.dart';
import 'package:yaki/presentation/state/providers/teammate_provider.dart';

final teammateFutureProvider =
    FutureProvider.autoDispose<GroupedUserWithDeclaration>((ref) {
  final teammateRepo = ref.watch(teammateRepositoryProvider);
  final filter = ref.watch(filterProvider);
  final Future<GroupedUserWithDeclaration> groupedTeammateList =
      teammateRepo.getTeammate().then((list) {
    if (filter.selectedTeams.isNotEmpty) {
      list = list.where((element) {
        return filter.selectedTeams.contains(element.teamId);
      }).toList();
    }
    final groupData = groupBy(
      list,
      (TeammateWithDeclarationEntity tmDecla) {
        if (tmDecla.userId == tmDecla.loggedUserId) {
          return me;
        }
        if (tmDecla.declarationStatus == StatusEnum.fromValue("absence") &&
            tmDecla.declarationStatusAfternoon == null) {
          return absent;
        } else if (tmDecla.declarationStatus ==
            StatusEnum.fromValue(StatusEnum.undeclared.name)) {
          return notDeclared;
        } else {
          return myCoworkers;
        }
      },
    );
    return GroupedUserWithDeclaration(
      me: groupData[me] ?? [],
      myCoworkers: groupData[myCoworkers] ?? [],
      notDeclared: groupData[notDeclared] ?? [],
      absent: groupData[absent] ?? [],
    );
  });

  return groupedTeammateList;
});

final String me = UserWitHDeclarationCategoryEnum.me.name;
final String myCoworkers = UserWitHDeclarationCategoryEnum.myCoworkers.name;
final String notDeclared = UserWitHDeclarationCategoryEnum.notDeclared.name;
final String absent = UserWitHDeclarationCategoryEnum.absent.name;
