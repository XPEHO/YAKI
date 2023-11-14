import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDeclared =
        await ref.read(declarationProvider.notifier).getLatestDeclaration();
    bool isLoggedIn = prefs.containsKey('token');

    if (isLoggedIn) {
      await ref.read(avatarProvider.notifier).getAvatar();
    }

    Timer(Duration.zero, () {
      if (isLoggedIn && isDeclared) {
        context.go('/teams-declaration-summary');
      } else if (isLoggedIn) {
        context.go('/team-selection');
      } else {
        context.go('/authentication');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColor,
                AppColors.secondaryColor,
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.5,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SvgPicture.asset(
                  'assets/images/splashscreen.svg',
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
