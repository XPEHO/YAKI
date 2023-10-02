import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/domain/entities/summary_half_day_content.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/features/declaration_summary/view/summary_chips_duo.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';

class SummaryHalfDay extends StatelessWidget {
  final DeclarationTeamsInfo halfDayTeamsInfo;

  const SummaryHalfDay({
    super.key,
    required this.halfDayTeamsInfo,
  });

  @override
  Widget build(BuildContext context) {
    SummaryHalfDayContent summaryHalfDayContent = setSummaryHalfDayContent(
      halfDayTeamsInfo: halfDayTeamsInfo,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr("morning").toUpperCase(),
          style: textStyleSummarySubtitle(),
        ),
        const SizedBox(height: 16),
        summaryHalfDayContent.morningStatus == StatusEnum.absence
            ? IconChip(
                label: tr(StatusEnum.absence.name),
                backgroundColor: Colors.white,
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SvgPicture.asset(
                    "assets/images/absence.svg",
                    width: 40,
                    height: 40,
                  ),
                ),
              )
            : SummaryChipDuo(
                status: summaryHalfDayContent.morningStatus,
                team: summaryHalfDayContent.morningTeam,
              ),
        const SizedBox(height: 36),
        Text(tr("afternoon").toUpperCase(), style: textStyleSummarySubtitle()),
        const SizedBox(height: 16),
        summaryHalfDayContent.afternoonStatus == StatusEnum.absence
            ? IconChip(
                label: tr(StatusEnum.absence.name),
                backgroundColor: Colors.white,
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SvgPicture.asset(
                    "assets/images/absence.svg",
                    width: 40,
                    height: 40,
                  ),
                ),
              )
            : SummaryChipDuo(
                status: summaryHalfDayContent.afternoonStatus,
                team: summaryHalfDayContent.afternoonTeam,
              ),
      ],
    );
  }
}

SummaryHalfDayContent setSummaryHalfDayContent({
  required DeclarationTeamsInfo halfDayTeamsInfo,
}) {
  return halfDayTeamsInfo.firstToDSelection == StatusEnum.morning
      ? SummaryHalfDayContent(
          morningTeam: halfDayTeamsInfo.firstTeam,
          morningStatus: halfDayTeamsInfo.firstStatus,
          afternoonTeam: halfDayTeamsInfo.secondTeam,
          afternoonStatus: halfDayTeamsInfo.secondStatus,
        )
      : SummaryHalfDayContent(
          morningTeam: halfDayTeamsInfo.secondTeam,
          morningStatus: halfDayTeamsInfo.secondStatus,
          afternoonTeam: halfDayTeamsInfo.firstTeam,
          afternoonStatus: halfDayTeamsInfo.firstStatus,
        );
}
