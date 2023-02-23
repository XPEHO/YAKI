import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/HeaderTextStyle.dart';
import 'package:yaki/presentation/ui/shared/views/ButtonApp.dart';
import 'package:yaki/presentation/ui/shared/views/InputApp.dart';
import 'presentation/ui/shared/views/Header.dart';

import 'package:easy_localization/easy_localization.dart';

class Authentification extends StatefulWidget {


  const Authentification({super.key});

  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {

  bool isChecked = false;


  @override
  Widget build(BuildContext context) {

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
                                    padding: EdgeInsets.only(top: size.height/15, right: 50, left: 50),
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
                                    padding: const EdgeInsets.only(left : 40, top: 10),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: isChecked,
                                            activeColor: HeaderColor.yellowApp,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isChecked = value!;
                                              });
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
                                    padding: const EdgeInsets.only(top : 10),
                                    child: ButtonApp(textButton: tr('signIn')
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
                                  )
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
