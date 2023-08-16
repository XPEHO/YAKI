import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/halfday_status_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/shared/views/avatar_icon.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';

void _routeHandling(BuildContext context) {
  context.go('/morningDeclaration');
}

class StatusRecapHalfDay extends ConsumerWidget {
  const StatusRecapHalfDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final halfdayDeclarations = ref.watch(halfdayStatusPageProvider);

    debugPrint("inside halfdayDeclarations page");
    debugPrint(halfdayDeclarations.morning.text);
    debugPrint(halfdayDeclarations.afternoon.text);

    return Scaffold(
      backgroundColor: AppColors.yakiPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topRight,
                  child: AvatarIcon(
                    pictoIcon: 'assets/images/avatar1.svg',
                    onPressed: () {
                      context.push('/profile');
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: CircleAvatarSVG(
                    iconPath: tr(halfdayDeclarations.morning.image),
                    radius: 80,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    halfdayDeclarations.morning.text,
                    style: textStyleHeaderBig(),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: CircleAvatarSVG(
                    iconPath: tr(halfdayDeclarations.afternoon.image),
                    radius: 80,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    halfdayDeclarations.afternoon.text,
                    style: textStyleHeaderBig(),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      width: 150,
                      height: 50,
                    ),
                    child: ElevatedButton(
                      onPressed: () => _routeHandling(context),
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
