import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';

class FailToFetchDataList extends StatelessWidget {
  final Function onPressed;

  const FailToFetchDataList({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "😱",
              style: textFetchError(fontSize: 65),
            ),
            const SizedBox(height: 20),
            Text(
              tr('oops'),
              style: textFetchError(fontSize: 30),
            ),
            const SizedBox(height: 10),
            Text(
              tr('somethingWentWrong'),
              style: textFetchError(fontSize: 20),
            ),
            const SizedBox(height: 90),
            SizedBox(
              width: 300,
              child: Button.secondary(
                text: tr("retry"),
                buttonHeight: 52,
                onPressed: () => onPressed(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
