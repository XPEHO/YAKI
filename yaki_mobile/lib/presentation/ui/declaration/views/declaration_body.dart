import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card.dart';

import '../../../state/providers/team_provider.dart';
import '../../team/views/team_card.dart';

/// using ConsumerStatefulWidget (statefullWidget) to have access to the WidgetRef object
/// allowing the current widget to have access to any provider.
class DeclarationBody extends ConsumerWidget {
  const DeclarationBody({Key? key}) : super(key: key);

  /// when a statusCard is selected / pressed / taped
  /// * access the declarationNotifier to invoke the create method
  /// * pass the selected status String.
  /// ( get the StatusEnum text from card content, as its the format that need to be send to the back )
  /// * Then invoke the statusNotifier getSelectedStatus change the state to set displayed data in the status page.
  /// * Finally trigger router to change to the status page.
  Future<void> _onStatusSelected({
    required WidgetRef ref,
    required String status,
    required Function goToStatusPage,
    required BuildContext context,
  }) async {
    Widget setupAlertDialoadContainer() {
      final listTeam = ref.watch(teamProvider);
      return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listTeam.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(listTeam[index].teamName ?? "No name available"),
            );
          },
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select a team"),
        content: setupAlertDialoadContainer(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Ok"),
          )
        ],
      ),
    );
    ref.read(declarationProvider.notifier).createAllDay(status);
    ref.read(statusPageProvider.notifier).getSelectedStatus();
    goToStatusPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;

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
                    status: StatusEnum.values.byName(cardContent['text']).text,
                    goToStatusPage: () => context.go('/status'),
                    context: context,
                  ),
                  isSelected: false,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
