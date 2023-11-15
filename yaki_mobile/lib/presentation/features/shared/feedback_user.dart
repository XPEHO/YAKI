import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
          onTap: () async {
            const String url = 'mailto:yaki@xpeho.fr';
            final Uri uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              if (!await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch $url');
              }
            }
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
