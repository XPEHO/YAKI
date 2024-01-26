import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/shared/team_logo_image.dart';
import 'package:yaki_ui/yaki_ui.dart';

class SummaryChipDuo extends StatelessWidget {
  final StatusEnum status;
  final TeamModel team;

  const SummaryChipDuo({
    super.key,
    required this.status,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconChip(
          label: team.teamName,
          backgroundColor: Colors.white,
          borderWidth: 2,
          fontSizeLabel: 20,
          image: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: TeamLogoImage(
              size: 32,
              teamId: team.teamId,
              teamName: team.teamName,
            ),
          ),
        ),
        const SizedBox(height: 8),
        IconChip(
          label: tr(status.name),
          backgroundColor: Colors.white,
          borderWidth: 2,
          fontSizeLabel: 20,
          image: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: UserDeclarationChipSvgPicture(
              imageSrc: setTimeOfDayImage(status),
            ),
          ),
        ),
      ],
    );
  }
}

String setTimeOfDayImage(StatusEnum status) {
  switch (status) {
    case StatusEnum.onSite:
      return "assets/images/Work-Office.svg";
    case StatusEnum.remote:
      return "assets/images/Work-Home.svg";
    default:
      return "assets/images/absent.svg";
  }
}
