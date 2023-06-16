import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/providers/team_mate_provider.dart';
import 'package:yaki/presentation/ui/captain/views/team_mate_card.dart';

/// using ConsumerStatefulWidget (statefullWidget) to have access to the WidgetRef object
/// allowing the current widget to have access to any provider.
/// ConsumerStatefulWidget, is used to have access to the statefull initState() method ( and override it )
class CaptainBody extends ConsumerStatefulWidget {
  const CaptainBody({super.key});

  @override
  ConsumerState<CaptainBody> createState() => _CaptainBodyState();
}

class _CaptainBodyState extends ConsumerState<CaptainBody> {
  final captainInputController = TextEditingController();

  /// Retrieves data from the team_mate_notifier.dart
  @override
  void initState() {
    setState(() {
      ref.read(teamMateProvider.notifier).fetchTeamMates();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Monitors changes in card status
    final listTeamMate = ref.watch(teamMateProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          ref.read(teamMateProvider.notifier).fetchTeamMates();
        });
      },
      child: ListView.builder(
        // This widget allows you to create a list object and iterate on it
        itemCount: listTeamMate.length,
        itemBuilder: (context, index) {
          return CardTeamMate(
            // Cards of the Team Mate
            firstName: (listTeamMate[index].userFirstName),
            lastName: (listTeamMate[index].userLastName),
            dateActu: (listTeamMate[index].declarationDate),
            status: (listTeamMate[index].declarationStatus),
          );
        },
      ),
    );
  }
}
