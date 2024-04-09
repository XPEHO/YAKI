import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki/presentation/state/providers/token_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  bool _isTokenSaved = false;
  bool _isDeclared = false;
  bool _isTokenValid = false;
  late bool _isNotificationPermitted;
  static const platform = MethodChannel('com.xpeho.yaki/notification');

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void handleRedirection() {
    if (!_isTokenSaved || !_isTokenValid) {
      context.go('/authentication');
      return;
    }

    if (_isDeclared) {
      context.go('/teams-declaration-summary');
    } else {
      context.go('/team-selection');
    }
  }

  /// Check if user is logged in and if token is valid.
  /// If user is logged in and token is valid, get avatar.
  void isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isTokenSaved = prefs.containsKey('token');

    _isNotificationPermitted = prefs.containsKey('notificationPermission');
    if (!_isNotificationPermitted) {
      await prefs.setBool('notificationPermission', true);
      scheduleNotifications();
      _isNotificationPermitted = prefs.containsKey('notificationPermission');
    }
    debugPrint(
      'Notification permission is in shared preferences : $_isNotificationPermitted',
    );

    // if token is not saved, no need to check for token validity
    if (!_isTokenSaved) {
      handleRedirection();
      return;
    }

    _isTokenValid =
        await ref.read(tokenRepositoryProvider).verifyTokenValidity();

    // if token is not valid, no need to check for declaration as user going to authentication page
    if (!_isTokenValid) {
      handleRedirection();
      return;
    }

    //  get avatar
    await ref.read(avatarProvider.notifier).getAvatar();

    // get if user is declared
    await ref.read(declarationProvider.notifier).getLatestDeclaration();

    _isDeclared = ref.read(declarationProvider).latestDeclarationStatus ==
        LatestDeclarationStatus.declared;

    if (_isDeclared) {
      // get the user team list if direct redirect to the team declaration summary page.
      // will be used to compare if logged user, is in the team of the users displayed in the list.
      await ref.read(teamProvider.notifier).getUserTeamList();
    }

    handleRedirection();
  }

  void scheduleNotifications() async {
    debugPrint('scheduleNotifications');
    try {
      await platform.invokeMethod('scheduleNotifications');
    } on PlatformException catch (e) {
      debugPrint('Error: ${e.message}');
    }
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
