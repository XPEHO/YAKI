import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/state/providers/status_provider.dart';
import 'package:yaki/presentation/styles/header_text_style.dart';
import 'package:yaki/presentation/ui/shared/views/input_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

class Authentication extends ConsumerWidget {
  Authentication({super.key});

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  void onPressAuthent({
    required WidgetRef ref,
    required String login,
    required String password,
    required Function goToDeclarationPage,
    required Function goToStatusPage,
    required Function goToCaptain,
  }) async {
    final bool isCaptain = await ref
        .read(loginRepositoryProvider)
        .userAuthentication(login, password);
    if (await isTokenPresent()) {
      if (isCaptain) {
        goToCaptain();
      }
      final declarationStatus =
          await ref.read(declarationProvider.notifier).getDeclaration();
      if (declarationStatus != emptyDeclarationStatus) {
        ref.read(statusPageProvider.notifier).getSelectedStatus();
        goToStatusPage();
      } else {
        goToDeclarationPage();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isChecked = false;

    // Size of the device
    var size = MediaQuery.of(context).size;

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
                        ),
                        child: Text(tr('signIn')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        tr('forgotPassword'),
                        style: const TextStyle(
                          color: Colors.purple,
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
