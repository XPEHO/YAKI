import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/state/providers/provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card.dart';

void _createDeclaration(WidgetRef ref, String declaration) {
  ref.read(declarationProvider.notifier).create(declaration);
}

void _routeHandling(BuildContext context) {
  context.push('/status');
}

// ConsumerWidget : stateless widget listening to providers
class DeclarationBody extends ConsumerWidget {
  const DeclarationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.12,
        horizontal: MediaQuery.of(context).size.width * 0.09,
      ),
      child: Center(
        child: Wrap(
          spacing: MediaQuery.of(context).size.width * 0.07,
          runSpacing: MediaQuery.of(context).size.width * 0.12,
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