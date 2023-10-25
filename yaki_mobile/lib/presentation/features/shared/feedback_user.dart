import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class FeedbackUser extends StatelessWidget {
  const FeedbackUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // This is a modal bottom sheet. This need to be delete when the method will be implemented
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('Coming soon'),
                  ),
                );
              },
            );
          },
          child: Row(
            children: [
              Text(
                tr('feedback'),
                style: textFeedback(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
