import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/login_state.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/ui/shared/views/ButtonApp.dart';
import 'package:yaki/presentation/ui/shared/views/InputApp.dart';
import 'presentation/ui/shared/views/Header.dart';
import 'package:yaki/presentation/styles/HeaderTextStyle.dart';
import 'package:easy_localization/easy_localization.dart';

class Authentification extends ConsumerWidget {
  bool isChecked = false;

  Authentification({super.key});

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final providerLogin = ref.watch(loginProvider).login;
    final providerPassword = ref.watch(loginProvider).password;

    void getClick() {
      ref
          .read(loginProvider.notifier)
          .changeLogin(loginController.text, passwordController.text);
    }

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
                          top: size.height / 15, right: 50, left: 50),
                      child: TextField(
                        controller: loginController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: tr('inputLogin'),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 50, left: 50),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: tr('hintPassword'),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: HeaderColor.yellowApp,
                            onChanged: (bool? value) {
                              // setState(() {
                              //   isChecked = value!;
                              // });
                            },
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
                      child: ButtonApp(
                        textButton: tr('signIn'),
                        fonction: getClick,
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
                    Text(providerLogin)
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
