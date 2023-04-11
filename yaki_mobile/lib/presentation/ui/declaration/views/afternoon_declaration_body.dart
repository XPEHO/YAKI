import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/halfday_status_provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card.dart';

/// using ConsumerStatefulWidget (statefullWidget) to have access to the WidgetRef object
/// allowing the current widget to have access to any provider.
class AfternoonDeclarationBody extends ConsumerWidget {
  const AfternoonDeclarationBody({Key? key}) : super(key: key);

  _onStatusSelected({
    required WidgetRef ref,
    required String morningStatus,
    required String afternoonStatus,
    required Function goToStatusPage,
  }) async {
    // ref
    //     .read(declarationProvider.notifier)
    //     .setAfternoonDeclaration(afternoonStatus);
    // await ref
    //     .read(declarationProvider.notifier)
    //     .createMorning(morningStatus, afternoonStatus);
    // await ref
    //     .read(declarationProvider.notifier)
    //     .createAfternoon(afternoonStatus);
    await ref
        .read(declarationProvider.notifier)
        .createHalfDay(morningStatus, afternoonStatus);
    // set la state dans le status_notifier.dart avec la valeur du morning
    ref.read(halfdayStatusPageProvider.notifier).getHalfdayDeclaration();
    goToStatusPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;
    var morningDeclaration =
        ref.watch(declarationProvider.notifier).getMorningDeclaration();

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.12,
        horizontal: width * 0.09,
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          // horizontal
          spacing: width * 0.07,
          // vertical
          runSpacing: width * 0.12,
          children: statusCardsContent
              .map(
                (cardContent) => StatusCard(
                  statusName: tr(cardContent['text']),
                  statusPicto: cardContent['image'],
                  onPress: () => _onStatusSelected(
                    ref: ref,
                    morningStatus: morningDeclaration,
                    afternoonStatus:
                        StatusEnum.values.byName(cardContent['text']).text,
                    goToStatusPage: () => context.go('/halfdayStatus'),
                  ),
                  isSelected:
                      StatusEnum.values.byName(cardContent['text']).text ==
                          morningDeclaration,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
