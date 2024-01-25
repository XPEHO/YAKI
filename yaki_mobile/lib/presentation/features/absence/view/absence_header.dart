import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class AbsenceHeader extends StatelessWidget {
  const AbsenceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('absenceTitle1'),
            style: textStylePageTitle(),
          ),
          Text(
            tr('absenceTitle2'),
            style: textStylePageTitle(),
          ),
        ],
      ),
    );
  }
}
