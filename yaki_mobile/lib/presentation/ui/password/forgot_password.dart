import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/password_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/registration/view/registration_snackbar.dart';
import 'package:yaki/presentation/ui/shared/views/confirmation_elevated_button.dart';
import 'package:yaki/presentation/ui/shared/views/input_registration_page.dart';
import 'package:yaki/presentation/ui/registration/form_functionality.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // function calling the snackbar
  showSnackBar({
    required String content,
    required TextStyle textStyle,
    required String actionLabel,
    required Function barAction,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      registrationSnack(
        content: content,
        textStyle: textStyle,
        barAction: barAction,
        actionLabel: actionLabel,
      ),
    );
  }

  Future<void> forgotPasswordValidation() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(passwordProvider.notifier).forgotPassword(
            emailController.text,
          );

      final forgotPasswordState = ref.read(passwordProvider);

      if (forgotPasswordState == true) {
        showSnackBar(
          content: tr('resetPasswordSuccess'),
          textStyle: registrationSnackTextStyle(
            textColor: const Color.fromARGB(255, 99, 203, 64),
          ),
          actionLabel: tr('registrationSnackValidation'),
          barAction: () {
            context.go('/authentication');
          },
        );
      } else {
        showSnackBar(
          content: tr('changePasswordError'),
          textStyle: registrationSnackTextStyle(
            textColor: const Color.fromARGB(255, 182, 44, 44),
          ),
          actionLabel: tr('registrationCancelButton'),
          barAction: () {},
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yakiPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(
                tr('resetPassword'),
                style: registrationPageTitleTextStyle(),
              ),
            ),
            Form(
              key: _formKey,
              child: InputRegistration(
                textInputAction: TextInputAction.done,
                controller: emailController,
                label: tr('registrationInputEmailLabel'),
                validatorFunction: emailValidator,
                isShown: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ConfirmationElevatedButton(
                text: tr('changePasswordPageConfimButton'),
                onPressed: forgotPasswordValidation,
                foregroundColor: const Color.fromARGB(212, 183, 146, 14),
                backgroundColor: const Color.fromARGB(255, 220, 219, 219),
                btnTextStyle: registrationBtnTextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ConfirmationElevatedButton(
                text: tr('registrationCancelButton'),
                onPressed: () => context.go("/"),
                foregroundColor: const Color.fromARGB(212, 183, 146, 14),
                backgroundColor: const Color.fromARGB(255, 107, 97, 96),
                btnTextStyle: registrationCancelTextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
