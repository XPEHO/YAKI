import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/password_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/registration/form_functionality.dart';
import 'package:yaki/presentation/ui/registration/view/registration_snackbar.dart';
import 'package:yaki/presentation/ui/shared/views/confirmation_elevated_button.dart';
import 'package:yaki/presentation/ui/shared/views/input_registration_page.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final newPasswordConfirmation = TextEditingController();
  //form state
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

  // Validation of the form
  Future<void> passwordChangeValidation() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(passwordProvider.notifier).changePassword(
            currentPassword.text,
            newPassword.text,
          );

      final changePasswordState = ref.read(passwordProvider);

      if (changePasswordState == true) {
        showSnackBar(
          content: tr('changePasswordSucess'),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  tr('changePasswordPageTitle'),
                  style: registrationPageTitleTextStyle(),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputRegistration(
                      textInputAction: TextInputAction.next,
                      controller: currentPassword,
                      label: tr('changePasswordPageOldPW'),
                      validatorFunction: passwordValidator,
                      isShown: true,
                    ),
                    InputRegistration(
                      textInputAction: TextInputAction.next,
                      controller: newPassword,
                      label: tr('changePasswordPageNewPW'),
                      validatorFunction: passwordValidator,
                      isShown: true,
                    ),
                    InputRegistration(
                      textInputAction: TextInputAction.done,
                      controller: newPasswordConfirmation,
                      label: tr('changePasswordPageNewPWConfirm'),
                      validatorFunction: (value) =>
                          pwConfirmationValidator(value, newPassword.text),
                      isShown: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ConfirmationElevatedButton(
                    text: tr('changePasswordPageConfimButton'),
                    onPressed: passwordChangeValidation,
                    foregroundColor: const Color.fromARGB(212, 183, 146, 14),
                    backgroundColor: const Color.fromARGB(255, 220, 219, 219),
                    btnTextStyle: registrationBtnTextStyle(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  width: double.infinity,
                  child: ConfirmationElevatedButton(
                    text: tr('registrationCancelButton'),
                    onPressed: () => context.go("/profile"),
                    foregroundColor: const Color.fromARGB(212, 183, 146, 14),
                    backgroundColor: const Color.fromARGB(255, 107, 97, 96),
                    btnTextStyle: registrationCancelTextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
