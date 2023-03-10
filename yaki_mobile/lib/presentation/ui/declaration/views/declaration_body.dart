import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card_test_media.dart';

// ConsumerWidget : stateless widget listening to providers
class DeclarationBody extends ConsumerWidget {
  const DeclarationBody({Key? key}) : super(key: key);

  Future<void> _onStatusSelected({
    required WidgetRef ref,
    required String status,
    required Function goToStatusPage,
  }) async {
    await ref.read(declarationProvider.notifier).create(status);
    final declaration = ref.read(declarationProvider).state;
    if(declaration !=null) {
      goToStatusPage();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.12,
        horizontal:width * 0.09,
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
                  getClick: () => _onStatusSelected(
                    ref: ref,
                    status: cardContent['text'],
                    goToStatusPage: () => context.go('/status'),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

//           spacing: MediaQuery.of(context).size.width * 0.07,
//           runSpacing: MediaQuery.of(context).size.width * 0.12,
