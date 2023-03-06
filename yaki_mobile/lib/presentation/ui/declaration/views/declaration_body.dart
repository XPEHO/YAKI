import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/state/providers/provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card.dart';


void _routeHandling(BuildContext context) {
  context.go('/status');
}

void _createDeclaration(WidgetRef ref, String declaration) {
  ref.read(declarationProvider.notifier).create(declaration);
}

// ConsumerWidget : stateless widget listening to providers
class DeclarationBody extends ConsumerWidget {
  const DeclarationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width < 670 ? width * 0.12 : 50,
        horizontal: width < 670 ? width * 0.09 : 50,
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          // horizontal
          spacing: width < 670 ? width * 0.07 : width * 0.03,
          // vertical
          runSpacing: width < 670 ? width * 0.12 : width * 0.05,
          children: statusCardContent
              .map(
                (cardContent) => StatusCard(
                  statusName: tr(cardContent['text']),
                  statusPicto: cardContent['image'],
                  getClick: () {
                    _createDeclaration(ref, cardContent['text']);
                    _routeHandling(context);
                  },
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