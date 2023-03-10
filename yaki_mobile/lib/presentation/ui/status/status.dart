import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/styles/header_text_style.dart';
import 'package:yaki/presentation/ui/shared/views/avatar_icon.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';

void _routeHandling(BuildContext context) {
  //context.pop();
  context.go('/declaration');
}

void onAvatarIconPress() {}

class Status extends ConsumerWidget {
  const Status({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(statusPageProvider);

    return Scaffold(
      backgroundColor: HeaderColor.yellowApp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: AvatarIcon(
                  pictoIcon: 'assets/images/avatar1.svg',
                  onPressed: onAvatarIconPress,
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: CircleAvatarSVG(
                    iconPath: selectedStatus.image,
                    radius: 80,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    selectedStatus.text,
                    style: textStyleTemp(),
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
                      onPressed: () => _routeHandling(context),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.grey[400],
                      ),
                      child: const Text(
                        "Change",
                        style: TextStyle(
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
