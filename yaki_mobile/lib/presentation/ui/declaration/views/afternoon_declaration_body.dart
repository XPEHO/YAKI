import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card.dart';
import 'package:yaki/presentation/ui/shared/views/team_selection_dialog.dart';

/// using ConsumerStatefulWidget (statefullWidget) to have access to the WidgetRef object
/// allowing the current widget to have access to any provider.
class AfternoonDeclarationBody extends ConsumerWidget {
  const AfternoonDeclarationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Retrieves the morning declaration
    var morningDeclaration =
        ref.watch(declarationProvider.notifier).getMorningStatus();

    return Padding(
      padding: const EdgeInsets.all(20),
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
                  onPress: () => TeamSelectionDialog(
                    ref: ref,
                    context: context,
                    allDayStatus: null,
                    morningStatus: morningDeclaration,
                    afternoonStatus:
                        StatusEnum.getValue(key: cardContent['text']),
                    goToPage: () => context.go('/halfdayStatus'),
                  ).show(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
