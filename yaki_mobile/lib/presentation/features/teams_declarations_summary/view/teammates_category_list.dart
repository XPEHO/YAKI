import 'package:flutter/material.dart';
import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_card.dart';
import 'package:yaki/presentation/styles/color.dart';

class TeammatesCategoryList extends StatelessWidget {
  final List<TeammateWithDeclarationEntity> teammatesCategory;

  const TeammatesCategoryList({super.key, required this.teammatesCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.teamsDeclarationListBorder,
          width: 1,
        ),
      ),
      child: ListView.separated(
        itemCount: teammatesCategory.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return CellCard(
            teammate: teammatesCategory[index],
            isModifierBtnUsed: false,
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
            color: AppColors.teamsDeclarationListDivider,
            height: 0,
          );
        },
      ),
    );
  }
}
