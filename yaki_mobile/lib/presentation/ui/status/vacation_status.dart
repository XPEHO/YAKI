import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/state/providers/vacation_status_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/shared/views/avatar_icon.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';

void _routeHandling(BuildContext context, WidgetRef ref) {
  context.go('/team-selection');
  ref.read(teamProvider.notifier).clearTeamList();
}

void onAvatarIconPress() {}

class VacationStatus extends ConsumerWidget {
  const VacationStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(vacationStatusPageProvider);
    return Scaffold(
      backgroundColor: AppColors.yakiPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: AvatarIcon(
                  pictoIcon: 'assets/images/avatar1.svg',
                  onPressed: () {
                    context.go('/profile');
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: CircleAvatarSVG(
                    iconPath: tr(selectedStatus.image),
                    radius: 80,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    selectedStatus.text,
                    style: textStyleHeaderBig(),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      width: 150,
                      height: 50,
                    ),
                    child: ElevatedButton(
                      onPressed: () => _routeHandling(context, ref),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.grey[400],
                      ),
                      child: Text(
                        tr("statusButton"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
