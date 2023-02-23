import 'package:flutter/material.dart';
import 'presentation/ui/shared/views/Header.dart';

class Authentification extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // return the size of the device

    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 6,
            child: Header(
              pictoIcon: 'assets/images/dots.svg',
              pictoPath: 'assets/images/authent.svg',
              headerTitle: 'Authentification',
              headerHint: 'Who are you ?',
            )),
        Expanded(flex: 7, child: Container())
      ],
    ));
  }
=======
import 'package:yaki/presentation/ui/shared/views/ButtonApp.dart';
import 'package:yaki/presentation/ui/shared/views/InputApp.dart';
import 'presentation/ui/shared/views/Header.dart';

import 'package:easy_localization/easy_localization.dart';

class Authentification extends StatelessWidget {

  const Authentification({super.key});

  @override
  Widget build(BuildContext context) {
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
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 50, right: 50, left: 50),
                                child: InputApp(
                                  inputText: tr('inputLogin'),
                                  inputHint: tr('hintLogin'),
                                  password: false,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
                                child: InputApp(
                                  inputText: tr('inputPassword'),
                                  inputHint: tr('hintPassword'),
                                  password: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left : 40, top: 20),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: false,
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
                                padding: const EdgeInsets.only(top : 20),
                                child: ButtonApp(textButton: tr('signIn'),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Text(
                                  tr('forgotPassword'),
                                  style: const TextStyle(
                                    color: Colors.purple,
                                  ),
                                ),
                              )
                            ],
                          ),
                      ),
                  ),
                ],
              ),
          );
      }
}
