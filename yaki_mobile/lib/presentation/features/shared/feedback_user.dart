import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class FeedbackUser extends StatelessWidget {
  const FeedbackUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            final Uri uri = Uri.parse('mailto:yaki@xpeho.fr');
            if (await canLaunchUrl(uri)) {
              if (!await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch $uri');
              }
            }
          },
          child: Text(
            tr('feedback'),
            style: textFeedback(),
          ),
        ),
      ],
    );
  }
}
