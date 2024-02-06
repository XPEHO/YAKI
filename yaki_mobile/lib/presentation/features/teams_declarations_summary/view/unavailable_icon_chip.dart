import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki_ui/icon_chip.dart';

class UnavailableIconChip extends StatelessWidget {
  const UnavailableIconChip({super.key});

  @override
  Widget build(BuildContext context) {
    return IconChip(
      image: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: const CellIconChipSvgPicture(
          imageSrc: "assets/images/unavailable.svg",
        ),
      ),
      label: tr("unavailable"),
      backgroundColor: Colors.white,
    );
  }
}
