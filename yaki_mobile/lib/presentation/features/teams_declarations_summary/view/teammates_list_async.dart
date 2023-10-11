import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';
import 'package:yaki/presentation/displaydata/user_with_declaration_category_enum.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_card.dart';
import 'package:yaki/presentation/state/providers/teammate_future_provider.dart';
import 'package:yaki/presentation/styles/text_style.dart';
// import 'package:yaki/presentation/styles/text_style.dart';

class TeammateListAsync extends ConsumerWidget {
  const TeammateListAsync({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedUsersWithDeclaration = ref.watch(teammateFutureProvider);

    return groupedUsersWithDeclaration.when(
      data: (data) {
        final items = [
          if (data.me.isNotEmpty) me,
          ...data.me,
          if (data.myCoworkers.isNotEmpty) myCoworkers,
          ...data.myCoworkers,
          if (data.notDeclared.isNotEmpty) notDeclared,
          ...data.notDeclared,
          if (data.absent.isNotEmpty) absent,
          ...data.absent,
        ];

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            if (item is String) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, top: 24, bottom: 8),
                child: Text(
                  tr(item),
                  style: textTeamsDeclarationListCategory(),
                ),
              );
            }
            final TeammateWithDeclarationEntity entity =
                item as TeammateWithDeclarationEntity;
            if (entity.userId == entity.loggedUserId) {
              return CellCard(
                teammate: item,
                isModifierBtnUsed: true,
              );
            }
            return CellCard(teammate: entity, isModifierBtnUsed: false);
          },
        );
      },
      error: (error, stackTrace) => const Text(""),
      loading: () => const Text(""),
    );
  }
}

final String me = UserWitHDeclarationCategoryEnum.me.name;
final String myCoworkers = UserWitHDeclarationCategoryEnum.myCoworkers.name;
final String notDeclared = UserWitHDeclarationCategoryEnum.notDeclared.name;
final String absent = UserWitHDeclarationCategoryEnum.absent.name;
