import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card.dart';
import 'package:yaki/presentation/ui/shared/views/team_selection_dialog.dart';
import 'package:yaki/presentation/ui/vacation/vacation_selection_dialog.dart';

/// using ConsumerStatefulWidget (statefullWidget) to have access to
/// the WidgetRef object
/// allowing the current widget to have access to any provider.
class DeclarationBody extends ConsumerWidget {
  final DeclarationTimeOfDay timeOfDay;
  final String nextPage;

  const DeclarationBody({
    Key? key,
    required this.timeOfDay,
    required this.nextPage,
  }) : super(key: key);

  void onCardPressed({
    required WidgetRef ref,
    required BuildContext context,
    required String cardContent,
    required Function goToPage,
  }) async {
    if (cardContent != StatusEnum.vacation.name) {
      final getTeamCount = ref.read(teamProvider).selectedTeamList.length;
      if (getTeamCount == 1) {
        final teamList = ref.read(teamProvider);
        await ref.read(declarationProvider.notifier).createDeclaration(
              timeOfDay: timeOfDay,
              status: StatusEnum.getValue(key: cardContent),
              teamId: teamList.selectedTeamList.first.teamId!,
            );
        goToPage();
        return;
      }
      TeamSelectionDialog(
        ref: ref,
        context: context,
        timeOfDay: timeOfDay,
        status: StatusEnum.getValue(key: cardContent),
        goToPage: () => context.go(nextPage),
      ).show();
    }
    //if vacation is selected
    else {
      VacationSelectionDialog(
        ref: ref,
        context: context,
        goToPage: () => context.go('/vacationStatus'),
      ).show();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          // horizontal
          spacing: 20.0,
          // vertical
          runSpacing: 20.0,
          // map on a list to create a status card for each status
          children: statusCardsContent
              .map(
                (cardContent) => StatusCard(
                  statusName: tr(cardContent['text']),
                  statusPicto: cardContent['image'],
                  onPress: () => onCardPressed(
                    ref: ref,
                    context: context,
                    cardContent: cardContent['text'],
                    goToPage: () => context.go(nextPage),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
