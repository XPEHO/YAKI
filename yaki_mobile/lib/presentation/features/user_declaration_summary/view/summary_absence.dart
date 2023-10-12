import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class SummaryAbsence extends StatelessWidget {
  final DateTime? dateStart;
  final DateTime? dateEnd;

  const SummaryAbsence({
    super.key,
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
          style: textStylePageTitleSummary(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr('statusVacationDayFrom'),
              style: textStyleSummary(),
            ),
            const SizedBox(height: 16),
            Text(
              DateFormat('dd/MM/yyyy').format(dateStart!),
              style: textStyleSummary(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr('statusVacationDayTo'),
              style: textStyleSummary(),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('dd/MM/yyyy').format(dateEnd!),
              style: textStyleSummary(),
            ),
          ],
        ),
      ],
    );
  }
}
