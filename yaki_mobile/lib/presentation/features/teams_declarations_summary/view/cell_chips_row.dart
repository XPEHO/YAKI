import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/cell_iconchips.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki_ui/yaki_ui.dart';

class CellChipsRow extends StatelessWidget {
  final StatusEnum status;
  final StatusEnum? statusAfternoon;

  const CellChipsRow({
    super.key,
    required this.status,
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
            if (status != StatusEnum.undeclared && status != StatusEnum.absence)
              const CellCircleChipSvg(
                imageSrc: "assets/images/Logo-Team.svg",
                backgroundColor: AppColors.cellChipDefault,
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
              const CellCircleChipSvg(
                imageSrc: "assets/images/Logo-Team.svg",
                backgroundColor: AppColors.cellChipDefault,
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
      // full day
      return Row(
        children: [
          if (status != StatusEnum.undeclared && status != StatusEnum.absence)
            const CellCircleChipSvg(
              imageSrc: "assets/images/Logo-Team.svg",
              backgroundColor: AppColors.cellChipDefault,
            ),
          const SizedBox(width: 2.29),
          // display a IconChip instead of a CircleChip if the status is undeclared or absence
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
