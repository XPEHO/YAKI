import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class FeedbackUser extends StatelessWidget {
  const FeedbackUser({Key? key}) : super(key: key);

  Future<void> _launchURL() async {
    const url = 'mailto:yaki@xpeho.fr?subject=Feedback&body=';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _launchURL();
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      tr('feedbackMessage'),
                      style: textFeedback(),
                    ),
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
