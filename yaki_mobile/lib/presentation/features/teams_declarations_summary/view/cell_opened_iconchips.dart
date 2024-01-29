import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/shared/team_logo_image.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/unavailable_icon_chip.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki_ui/yaki_ui.dart';

/// Row displayed when the Cell_Card is OPEN
class CellOpenedIconChips extends ConsumerWidget {
  final int teamId;
  final String teamName;
  final StatusEnum status;
  final int? teamIdAfternoon;
  final String? teamNameAfternoon;
  final StatusEnum? statusAfternoon;

  const CellOpenedIconChips({
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isInTeamPresentNotAbsent) ...[
              IconChip(
                label: teamName,
                backgroundColor: AppColors.cellChipDefault,
                fontWeightLabel: FontWeight.w500,
                image: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: TeamLogoImage(
                    size: 16,
                    teamId: teamId,
                    teamName: teamName,
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
                height: 8,
              ),
            ],
            if (notInTeamPresentNotAbsent) const UnavailableIconChip(),
            // this ship is used to display the declaration status,
            //therefore it also need to be used when the user is in the current team
            if (isUserIsInTeam || absentOrUndeclared)
              IconChip(
                label: tr(status.name),
                backgroundColor: setStatusColor(status),
                fontWeightLabel: FontWeight.w500,
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CellIconChipSvgPicture(
                    imageSrc: setStatusImage(status),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        // AFTERNOON DECLARATION :  only if the statusAfternoon is not null
        if (statusAfternoon != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isUserIsInAfternoonTeam) ...[
                IconChip(
                  label: teamNameAfternoon!,
                  backgroundColor: AppColors.cellChipDefault,
                  fontWeightLabel: FontWeight.w500,
                  image: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: TeamLogoImage(
                      size: 16,
                      teamId: teamIdAfternoon!,
                      teamName: teamNameAfternoon!,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const SizedBox(height: 8),
                IconChip(
                  label: tr(statusAfternoon!.name),
                  backgroundColor: setStatusColor(statusAfternoon!),
                  fontWeightLabel: FontWeight.w500,
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CellIconChipSvgPicture(
                      imageSrc: setStatusImage(statusAfternoon!),
                    ),
                  ),
                ),
              ],
              // no need to display this chip if the user neither is into the morning team (only one unavailable chip is enough for the day)
              if (!isUserIsInAfternoonTeam && isUserIsInTeam)
                const UnavailableIconChip(),
            ],
          ),
      ],
    );
  }
}

String setStatusImage(StatusEnum status) {
  switch (status) {
    case StatusEnum.absence:
      return "assets/images/absent.svg";
    case StatusEnum.onSite:
      return "assets/images/Work-Office.svg";
    case StatusEnum.remote:
      return "assets/images/Work-Home.svg";
    case StatusEnum.undeclared:
    default:
      return "assets/images/unknown.svg";
  }
}

Color setStatusColor(StatusEnum status) {
  switch (status) {
    case StatusEnum.onSite:
      return AppColors.onSite;
    case StatusEnum.remote:
      return AppColors.remote;
    case StatusEnum.absence:
    case StatusEnum.undeclared:
    default:
      return Colors.white;
  }
}
