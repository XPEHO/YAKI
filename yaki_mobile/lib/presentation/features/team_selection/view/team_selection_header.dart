import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class TeamSelectionHeader extends StatelessWidget {
  const TeamSelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('teamSelectionPageTitle1'),
            style: textStylePageTitle(),
          ),
          Text(
            tr('teamSelectionPageTitle2'),
            style: textStylePageTitle(),
          ),
          const SizedBox(height: 15),
          Text(
            tr('teamSelectionPageHint'),
            style: textStylePageHint(),
          ),
        ],
      ),
    );
  }
}
