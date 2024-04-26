import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaki/domain/entities/team_logo_entity.dart';
import 'package:yaki/presentation/state/providers/team_logo_provider.dart';
import 'package:yaki/presentation/state/state/team_page_state.dart';

class TeamLogoImage extends ConsumerWidget {
  final double size;
  final int teamId;
  final String teamName;

  const TeamLogoImage({
    super.key,
    required this.size,
    required this.teamId,
    required this.teamName,
  });

  String getDefaultTeamLogoAssetPath(String teamName) {
    final picto = teamName == "Absence"
        ? 'assets/images/absent.svg'
        : 'assets/images/Logo-Team.svg';
    return picto;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TeamLogoEntity> teamLogoList = ref.watch(teamLogoProvider);

    // Create a map of teamLogoList,key is teamId, value is TeamLogoEntity
    final Map<int, TeamLogoEntity> teamLogoMap = {
      for (var teamLogo in teamLogoList) teamLogo.teamId: teamLogo,
    };

    // used as check to know if the team has a logo (retrive the value from the map where key is teamId)
    final teamLogoEntity = teamLogoMap[teamId];

    // teamId == absenceTeamId means that the team is Absence card
    if (teamId != absenceTeamId && teamLogoEntity != null) {
      return SizedBox(
        width: size,
        height: size,
        child: Image.memory(
          teamLogoEntity.teamLogo,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SvgPicture.asset(
        getDefaultTeamLogoAssetPath(teamName),
        width: size,
        height: size,
      );
    }
  }
}
