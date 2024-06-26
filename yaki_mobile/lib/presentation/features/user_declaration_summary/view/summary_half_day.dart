import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/user_declaration_summary/view/summary_chips_duo.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';

class SummaryHalfDay extends StatelessWidget {
  final DeclarationsHalfDaySelections halfDayData;

  const SummaryHalfDay({
    super.key,
    required this.halfDayData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr("morning").toUpperCase(),
          style: textStyleSummarySubtitle(),
        ),
        const SizedBox(height: 16),
        halfDayData.morningTeamStatus == StatusEnum.absence
            ? IconChip(
                label: tr(StatusEnum.absence.name),
                backgroundColor: Colors.white,
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const UserDeclarationChipSvgPicture(
                    imageSrc: "assets/images/absent.svg",
                  ),
                ),
              )
            : SummaryChipDuo(
                status: halfDayData.morningTeamStatus,
                team: halfDayData.morningTeam,
              ),
        const SizedBox(height: 36),
        Text(tr("afternoon").toUpperCase(), style: textStyleSummarySubtitle()),
        const SizedBox(height: 16),
        halfDayData.afternoonTeamStatus == StatusEnum.absence
            ? IconChip(
                label: tr(StatusEnum.absence.name),
                backgroundColor: Colors.white,
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const UserDeclarationChipSvgPicture(
                    imageSrc: "assets/images/absent.svg",
                  ),
                ),
              )
            : SummaryChipDuo(
                status: halfDayData.afternoonTeamStatus,
                team: halfDayData.afternoonTeam,
              ),
      ],
    );
  }
}
