import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/styles/header_text_style.dart';
import 'package:yaki/presentation/ui/shared/views/InputApp.dart';
import 'package:yaki/presentation/ui/shared/views/Header.dart';
import 'package:easy_localization/easy_localization.dart';

class Authentication extends ConsumerWidget {
  Authentication({super.key});

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  void onPressAuthent(WidgetRef ref, login, password) {
    final providerlogin = ref.read(loginProvider);

    ref.read(loginProvider.notifier).changeLogin(login, password);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isChecked = false;

    final providerlogin = ref.watch(loginProvider);

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
                        onPressed: () {
                          onPressAuthent(
                            ref,
                            loginController.text,
                            passwordController.text,
                          );
                          context.go('/declaration');
                        },
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
