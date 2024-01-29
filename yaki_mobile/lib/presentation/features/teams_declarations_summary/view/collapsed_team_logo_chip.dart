import 'package:flutter/material.dart';
import 'package:yaki/presentation/features/shared/team_logo_image.dart';
import 'package:yaki/presentation/styles/color.dart';

class CollapsedTeamLogoChip extends StatelessWidget {
  final int teamId;
  final String teamName;

  const CollapsedTeamLogoChip({
    super.key,
    required this.teamId,
    required this.teamName,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: AppColors.cellChipDefault,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: TeamLogoImage(
          size: 24,
          teamId: teamId,
          teamName: teamName,
        ),
      ),
    );
  }
}
