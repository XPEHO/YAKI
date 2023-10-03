import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
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
          label: team.teamName ?? tr('defaultTeamName'),
          backgroundColor: Colors.white,
          image: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SvgPicture.asset(
              "assets/images/onSite.svg",
              width: 40,
              height: 40,
            ),
          ),
        ),
        const SizedBox(height: 8),
        IconChip(
          label: tr(status.name),
          backgroundColor: Colors.white,
          image: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SvgPicture.asset(
              setTimeOfDayImage(status),
              width: 40,
              height: 40,
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
      return "assets/images/unknown.svg";
  }
}
