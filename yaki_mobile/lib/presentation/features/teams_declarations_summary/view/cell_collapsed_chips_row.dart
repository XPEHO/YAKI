import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_opened_iconchips.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/collapsed_team_logo_chip.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/unavailable_icon_chip.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

/// Row displayed when the Cell_Card is COLLAPSED
class CellCollapsedChipsRow extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    bool isUserIsInAfternoonTeam = false;

    bool isUserIsInTeam =
        ref.read(teamProvider.notifier).isTeamBelowToCurrentUser(
              teamName: teamName,
            );

    if (statusAfternoon != null) {
      isUserIsInAfternoonTeam =
          ref.read(teamProvider.notifier).isTeamBelowToCurrentUser(
                teamName: teamNameAfternoon!,
              );
    }

    final bool isInTeamPresentNotAbsent = isUserIsInTeam &&
        status != StatusEnum.undeclared &&
        status != StatusEnum.absence;

    final bool notInTeamPresentNotAbsent = !isUserIsInTeam &&
        status != StatusEnum.undeclared &&
        status != StatusEnum.absence;

    final bool absentOrUndeclared =
        status == StatusEnum.undeclared || status == StatusEnum.absence;

    if (statusAfternoon == null) {
      // FULL DAY
      return Row(
        children: [
          if (isInTeamPresentNotAbsent) ...[
            CollapsedTeamLogoChip(
              teamId: teamId,
              teamName: teamName,
            ),
            const SizedBox(width: 2.29),
            CellCircleChipSvg(
              imageSrc: setStatusImage(status),
              backgroundColor: setStatusColor(status),
            ),
          ],

          if (notInTeamPresentNotAbsent) const UnavailableIconChip(),

          // DISPLAY a ICONCHIP instead of a CircleChip if the status is UNDECLARED or ABSENCE
          if (absentOrUndeclared)
            IconChip(
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
    } else {
      // HALF DAY
      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          children: [
            // MORNING DECLARATION
            if (isUserIsInTeam) ...[
              if (status != StatusEnum.absence)
                // not display the team logo if the its an absence
                CollapsedTeamLogoChip(
                  teamId: teamId,
                  teamName: teamName,
                ),
              const SizedBox(width: 2.29),
              CellCircleChipSvg(
                imageSrc: setStatusImage(status),
                backgroundColor: setStatusColor(status),
              ),
            ],
            if (!isUserIsInTeam) const UnavailableIconChip(),

            const SizedBox(width: 2.29),

            // AFTERNOON DECLARATION
            if (isUserIsInAfternoonTeam) ...[
              if (statusAfternoon != StatusEnum.absence)
                // not display the team logo if the its an absence
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
            // no need to display this chip if the user neither is into the morning team (only one unavailable chip is enough for the day)
            if (!isUserIsInAfternoonTeam && isUserIsInTeam)
              const UnavailableIconChip(),
          ],
        ),
      );
    }
  }
}
