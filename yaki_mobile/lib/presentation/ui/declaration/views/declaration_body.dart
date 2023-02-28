import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/providers/provider.dart';
import 'package:yaki/presentation/ui/declaration/views/status_card.dart';

final List statusCardContent = [
  {
    'image': 'assets/images/remote.svg',
    'text': 'statusRemote',
  },
  {
    'image': 'assets/images/onsite.svg',
    'text': 'statusOnSite',
  },
  {
    'image': 'assets/images/vacation.svg',
    'text': 'statusVacation',
  },
  {
    'image': 'assets/images/dots.svg',
    'text': 'statusOther',
  },
];

void _createDeclaration(WidgetRef ref, String declaration) {

  ref.read(declarationProvider.notifier).create(declaration);
}

// ConsumerWidget : stateless widget listening to providers
class DeclarationBody extends ConsumerWidget {
  const DeclarationBody({Key? key}) : super(key: key);

  static const spacingMultiplier = 0.07;
  static const runSpacingMultiplier = 0.12;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Wrap(
        spacing: MediaQuery.of(context).size.width * spacingMultiplier,
        runSpacing: MediaQuery.of(context).size.width * runSpacingMultiplier,
        children: statusCardContent
            .map(
              (cardContent) => StatusCard(
                statusName: tr(cardContent['text']),
                statusPicto: cardContent['image'],
                getClick: () => _createDeclaration(
                  ref,
                  tr(
                    cardContent['text'],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
