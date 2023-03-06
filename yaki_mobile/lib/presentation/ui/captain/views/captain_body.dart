import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/ui/shared/views/Header.dart';
import 'package:yaki/presentation/ui/shared/views/InputApp.dart';

class CaptainBody extends ConsumerWidget {
  final captainInputController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: InputApp(
            inputText: tr('inputCaptain'),
            inputHint: tr('hintCaptain'),
            password: false,
            controller: captainInputController,
          ),
        ),
        SizedBox(
          width: size.width * 0.95,
          height: size.height * 0.15,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                CircleAvatarSVG(
                    iconPath: 'assets/images/captain.svg',
                    radius: 50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
