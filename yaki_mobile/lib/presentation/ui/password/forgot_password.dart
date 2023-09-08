import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/shared/views/confirmation_elevated_button.dart';
import 'package:yaki/presentation/ui/shared/views/input_registration_page.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final emailController = TextEditingController();

  String? emailValidator(String? value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9-_.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return tr('registrationInputNameError1');
    }
    if (!emailRegex.hasMatch(value)) {
      return tr('registrationInputEmailError');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Form(
              child: Column(
                children: [
                  InputRegistration(
                    // textInputAction: TextInputAction.next,
                    controller: emailController,
                    label: tr('registrationInputEmailLabel'),
                    validatorFunction: emailValidator,
                    isShown: false,
                    textCapitalization: (s) => (s),
                    // textCapit,
                  ),
                ],
              ),
            ),
// Padding(
//   padding: const EdgeInsets.only(top: 40),
//     child: ConfirmationElevatedButton(
//                     text: tr('ForgotPasswordPageConfimButton'),
//                     onPressed: forgotPasswordValidation,
//                     foregroundColor: const Color.fromARGB(212, 183, 146, 14),
//                     backgroundColor: const Color.fromARGB(255, 220, 219, 219),
//                     btnTextStyle: registrationBtnTextStyle(),
//                   ),
//                 ),
          )
        ],
      ),
    );
  }
}
