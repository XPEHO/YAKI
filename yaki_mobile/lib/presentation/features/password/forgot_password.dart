import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/password_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/features/registration/view/registration_snackbar.dart';
import 'package:yaki_ui/yaki_ui.dart';

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
            emailController.text.toLowerCase(),
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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.yakiPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go('/authentication');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height / 10),
            Image.asset(
              'assets/images/yaki_basti_icon.png',
              height: 100,
              width: 100,
            ),
            SizedBox(height: size.height / 20),
            Text(
              tr('resetPassword'),
              style: textStylePageTitle(),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: InputText(
                type: InputTextType.email,
                controller: emailController,
                label: tr('inputLogin'),
                readOnly: false,
              ),
            ),
            const SizedBox(height: 10),
            Button(
              buttonHeight: 72,
              text: tr('changePasswordPageConfimButton').toUpperCase(),
              onPressed: forgotPasswordValidation,
            ),
            const SizedBox(height: 5),
            Button.secondary(
              buttonHeight: 64,
              text: tr('registrationCancelButton').toUpperCase(),
              onPressed: () => context.go("/authentication"),
            ),
          ],
        ),
      ),
    );
  }
}
