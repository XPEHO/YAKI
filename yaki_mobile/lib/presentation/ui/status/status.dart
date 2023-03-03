import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/provider.dart';
import 'package:yaki/presentation/styles/header_text_style.dart';
import 'package:yaki/presentation/ui/shared/views/avatar_icon.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';

class Status extends ConsumerWidget {
  const Status({Key? key}) : super(key: key);

  void _routeHandling(BuildContext context) {
    context.pop();
  }
  void onAvatarIconPress() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final declarationStatus = ref.watch(declarationProvider);

    return Scaffold(
      backgroundColor: HeaderColor.yellowApp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Align(
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
                    iconPath: '${declarationStatus['image']}',
                    radius: 80,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    tr("${declarationStatus['text']}"),
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
