import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/features/shared/app_bar_date.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
import 'package:yaki/presentation/state/providers/user_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/shared/views/circle_avatar_svg.dart';

class UserDefaultRedirection extends ConsumerWidget {
  const UserDefaultRedirection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarWithDate(
        actions: <Widget>[
          IconButton(
            icon: const NavIconCircleAvatar(
              imageSrc: 'assets/images/Account.svg',
            ),
            onPressed: () {
              ref.read(userProvider.notifier).getUser();
              ref.read(avatarProvider.notifier).getAvatar();
              context.push('/profile');
            },
          ),
        ],
      ),
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
            iconPath: 'assets/images/Logo-Team.svg',
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
