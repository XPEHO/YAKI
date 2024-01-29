import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/shared/team_logo_image.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki_ui/yaki_ui.dart';

/// Row displayed when the Cell_Card is OPEN
class CellOpenedIconChips extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (status != StatusEnum.undeclared && status != StatusEnum.absence)
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
            ),
            const SizedBox(height: 8),
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
              if (statusAfternoon != StatusEnum.undeclared &&
                  statusAfternoon != StatusEnum.absence)
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
