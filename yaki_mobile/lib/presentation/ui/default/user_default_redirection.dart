import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';

class UserDefaultRedirection extends StatelessWidget {
  const UserDefaultRedirection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yakiPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr('userDefaultWelcome'),
            style: registrationPageTitleTextStyle(),
          ),
          Text(
            tr('userDefaultThanks'),
            style: registrationSnackTextStyle(textColor: Colors.black),
          ),
          const SizedBox(
            height: 40,
          ),
          const CircleAvatarSVG(
            iconPath: 'assets/images/onSite.svg',
            radius: 120,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('userDefaultTeamPart'),
                style: textStyleUserRedirectStyle(),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                tr('userDefaultTeam'),
                style: textStyleUserRedirectStyleTeam(),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            tr('userDefaultContact'),
            style: textStyleUserRedirectStyle(),
          ),
        ],
      ),
    );
  }
}
