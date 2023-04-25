import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card.dart';
import 'package:yaki/domain/entities/team_entity.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';

/// using ConsumerStatefulWidget (statefullWidget) to have access to the WidgetRef object
/// allowing the current widget to have access to any provider.
class MorningDeclarationBody extends ConsumerWidget {
  const MorningDeclarationBody({Key? key}) : super(key: key);

  _onStatusSelected({
    required WidgetRef ref,
    required String status,
    required Function goToAfternoonDeclaration,
    required BuildContext context,
  }) {
    final List<TeamEntity> listTeam = ref.watch(teamProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select a team"),
        content: Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listTeam.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {

                  ref.read(declarationProvider.notifier).setMorningDeclaration(status);
                  goToAfternoonDeclaration();
                },
                child: ListTile(
                  title: Text(listTeam[index].teamName ?? "No name available"),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );

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
                    goToAfternoonDeclaration: () =>
                        context.go('/afternoonDeclaration'),
                    context: context,
                  ),

                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
