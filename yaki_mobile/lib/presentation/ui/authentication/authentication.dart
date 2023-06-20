import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/halfday_status_provider.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/styles/header_text_style.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';
import 'package:yaki/presentation/ui/shared/views/input_app.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';

/// using ConsumerWidget (statelessWidget) to have access to the WidgetRef object
/// allowing the current widget to have access to any provider.
class Authentication extends ConsumerWidget {
  Authentication({super.key});

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isChecked = false;

    // Size of the device
    var size = MediaQuery.of(context).size;

    // Show a snackbar at the bottom of the screen to notice the user that
    // the login information he put are wrong
    showSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr('authenticationFailed')),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    /// on 'Sign in' button press/tap :
    /// * delete the previously saved token in the sharedPreferences
    /// * POST to the API the login information's, by invoking the loginRepositoryProvider.userAuthentication() method,
    /// then retrieve the boolean to know if the logged user is a captain.
    ///
    /// Depending of the newly saved token and if the user is a captain or not :
    /// * route to the captain page
    ///
    /// Or
    /// * route to the declaration page
    /// fetch the latest declaration and retrieve the status,
    ///
    /// if not null
    /// route to the status page directly
    ///
    /// if null
    /// route to the declaration page
    void onPressAuthent({
      required WidgetRef ref,
      required String login,
      required String password,
      required Function goToDeclarationPage,
      required Function goToStatusPage,
      required Function goToHalfdayStatusPage,
      required Function goToCaptain,
    }) async {
      await SharedPref.deleteToken();
      final bool authenticationResult = await ref
          .read(loginRepositoryProvider)
          .userAuthentication(login, password);
      if (authenticationResult && await SharedPref.isTokenPresent()) {
        final bool isCaptain = ref.read(loginRepositoryProvider).isCaptain();
        if (isCaptain) {
          goToCaptain();
        } else {
          ref.read(teamProvider.notifier).fetchTeams();
          final declarationStatus =
              await ref.read(declarationProvider.notifier).getDeclaration();
          if (declarationStatus.length > 1) {
            ref
                .read(halfdayStatusPageProvider.notifier)
                .getHalfdayDeclaration();
            goToHalfdayStatusPage();
          } else if (declarationStatus.length == 1 &&
              declarationStatus != emptyDeclarationStatus) {
            ref.read(statusPageProvider.notifier).getSelectedStatus();
            goToStatusPage();
          } else {
            goToDeclarationPage();
          }
        }
      } else {
        showSnackBar();
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Header(
              pictoIcon: 'assets/images/dots.svg',
              pictoPath: 'assets/images/authent.svg',
              headerTitle: tr('headerTitle'),
              headerHint: tr('headerHint'),
            ),
          ),
          Expanded(
            flex: 7,
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height / 15,
                        right: 50,
                        left: 50,
                      ),
                      child: InputApp(
                        inputText: tr('inputLogin'),
                        inputHint: tr('hintLogin'),
                        password: false,
                        controller: loginController,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 50, left: 50),
                      child: InputApp(
                        inputText: tr('inputPassword'),
                        inputHint: tr('hintPassword'),
                        password: true,
                        controller: passwordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: HeaderColor.yellowApp,
                            onChanged: (bool? value) {},
                          ),
                          Text(
                            tr('rememberMe'),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: HeaderColor.yellowApp,
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: size.height / 25,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 50,
                            left: 50,
                          ),
                        ),
                        onPressed: () => onPressAuthent(
                          ref: ref,
                          login: loginController.text,
                          password: passwordController.text,
                          goToDeclarationPage: () =>
                              context.push('/declaration'),
                          goToStatusPage: () => context.go('/status'),
                          goToCaptain: () => context.go('/captain'),
                          goToHalfdayStatusPage: () =>
                              context.go('/halfdayStatus'),
                        ),
                        child: Text(tr('signIn')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        tr('forgotPassword'),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
