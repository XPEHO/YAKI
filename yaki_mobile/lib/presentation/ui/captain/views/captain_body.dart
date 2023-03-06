import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/ui/shared/views/InputApp.dart';

class CaptainBody extends ConsumerWidget {

  final captainInputController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      ],
    );
  }

}