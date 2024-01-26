import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_opened_iconchips.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/collapsed_team_logo_chip.dart';
import 'package:yaki_ui/yaki_ui.dart';

/// Row displayed when the Cell_Card is COLLAPSED
class CellCollapsedChipsRow extends StatelessWidget {
  final int teamId;
  final String teamName;
  final StatusEnum status;
  final int? teamIdAfternoon;
  final String? teamNameAfternoon;
  final StatusEnum? statusAfternoon;

  const CellCollapsedChipsRow({
    super.key,
    required this.teamId,
    required this.teamName,
    required this.status,
    required this.teamIdAfternoon,
    required this.teamNameAfternoon,
    required this.statusAfternoon,
  });

  @override
  Widget build(BuildContext context) {
    if (statusAfternoon != null) {
      // half day
      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          children: [
            // MORNING DECLARATION
            if (status != StatusEnum.undeclared && status != StatusEnum.absence)
              CollapsedTeamLogoChip(
                teamId: teamId,
                teamName: teamName,
              ),
            const SizedBox(width: 2.29),
            CellCircleChipSvg(
              imageSrc: setStatusImage(status),
              backgroundColor: setStatusColor(status),
            ),
            const SizedBox(width: 2.29),

            // AFTERNOON DECLARATION
            if (statusAfternoon != StatusEnum.undeclared &&
                statusAfternoon != StatusEnum.absence)
              CollapsedTeamLogoChip(
                teamId: teamIdAfternoon!,
                teamName: teamNameAfternoon!,
              ),
            const SizedBox(width: 2.29),
            CellCircleChipSvg(
              imageSrc: setStatusImage(statusAfternoon!),
              backgroundColor: setStatusColor(statusAfternoon!),
            ),
          ],
        ),
      );
    } else {
      // FULL DAY
      return Row(
        children: [
          if (status != StatusEnum.undeclared && status != StatusEnum.absence)
            CollapsedTeamLogoChip(
              teamId: teamId,
              teamName: teamName,
            ),
          const SizedBox(width: 2.29),
          // DISPLAY a ICONCHIP instead of a CircleChip if the status is UNDECLARED or ABSENCE
          status != StatusEnum.undeclared && status != StatusEnum.absence
              ? CellCircleChipSvg(
                  imageSrc: setStatusImage(status),
                  backgroundColor: setStatusColor(status),
                )
              : IconChip(
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CellIconChipSvgPicture(
                      imageSrc: setStatusImage(status),
                    ),
                  ),
                  label: tr(status.name),
                  backgroundColor: Colors.white,
                ),
        ],
      );
    }
  }
}
