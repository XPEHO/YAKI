import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class SummaryAbsence extends StatelessWidget {
  final StatusEnum status;
  final DateFormat dateStart;
  final DateFormat dateEnd;

  const SummaryAbsence({
    super.key,
    required this.status,
    required this.dateStart,
    required this.dateEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr('SummaryAbsence'),
          style: textStylePageTitle(),
        ),
        Text(tr('statusVacationDayFrom')),
        Text(tr('statusVacationDayTo')),
      ],
    );
  }
}
