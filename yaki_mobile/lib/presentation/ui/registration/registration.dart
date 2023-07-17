import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/user_registration_provider.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/registration/view/registration_snackbar.dart';
import 'package:yaki/presentation/ui/shared/views/confirmation_elevated_button.dart';
import 'package:yaki/presentation/ui/shared/views/input_registration_page.dart';

class Registration extends ConsumerStatefulWidget {
  const Registration({super.key});

  @override
  ConsumerState<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends ConsumerState<Registration> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  //form state
  final _formKey = GlobalKey<FormState>();

  // function calling the snackbar
  showSnackBar({
    required String content,
    required TextStyle textStyle,
    required Function barAction,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      registrationSnack(
        content: content,
        textStyle: textStyle,
        barAction: barAction,
      ),
    );
  }

  // when press register button
  Future<void> formButtonValidation() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(userRegisterServiceProvider).registerUser(
            firstname: firstNameController.text,
            lastname: lastNameController.text,
            email: emailController.text,
            password: passwordConfirmController.text,
          );

      // after registration response get "isRegistered" value, being the object send from mobile API
      // confirming the registration was a success (no need others data)
      final bool registrationResult =
          ref.watch(userRegisterServiceProvider).userRegistered.isRegistered;

      // depending of true of false (will be changed to true only if code200) change snachbar message and message color
      if (registrationResult) {
        showSnackBar(
          content: tr("registrationSnackSuccess"),
          textStyle: registratonSnackTextStyle(
            textColor: const Color.fromARGB(255, 21, 76, 8),
          ),
          barAction: () {
            context.go('/');
          },
        );
      } else {
        showSnackBar(
          content: tr("registrationSnackError"),
          textStyle: registratonSnackTextStyle(
            textColor: const Color.fromARGB(255, 123, 5, 5),
          ),
          barAction: () {
            context.go('/');
          },
        );
      }
    }
  }

  // Validators for each input
  String? nameValidator(String? value) {
    final nameRegex = RegExp(r"^[A-Za-z ]+$");
    if (value == null || value.isEmpty) {
      return tr('registrationInputNameError1');
    }
    if (!nameRegex.hasMatch(value)) {
      return tr('registrationInputNameError2');
    }
    return null;
  }

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

  String? passwordValidator(String? value) {
    final passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[$£ù^&§+=:;.?,()é!@#\><*~]).{10}',
    );
    if (value != null && value.isEmpty) {
      return tr('registrationInputPasswordError1');
    }

    if (!passwordRegex.hasMatch(value!)) {
      return tr('registrationInputPasswordError2');
    }
    return null;
  }

  String? pwConfirmationValidator(String? value) {
    if (value != null && value.isEmpty) {
      return tr('registrationInputPassConfirmError1');
    }
    if (passwordController.text != value) {
      return tr('registrationInputPassConfirmError2');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 194, 80),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 30),
                  child: Text(
                    tr('registrationPageTitle'),
                    style: registrationPageTitleTextStyle(),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InputRegistration(
                        controller: firstNameController,
                        label: tr('registrationInputFirstnameLabel'),
                        validatorFunction: nameValidator,
                      ),
                      InputRegistration(
                        controller: lastNameController,
                        label: tr('registrationInputLastnameLabel'),
                        validatorFunction: nameValidator,
                      ),
                      InputRegistration(
                        controller: emailController,
                        label: tr('registrationInputEmailLabel'),
                        validatorFunction: emailValidator,
                      ),
                      InputRegistration(
                        controller: passwordController,
                        label: tr('registrationInputPasswordLabel'),
                        validatorFunction: passwordValidator,
                      ),
                      InputRegistration(
                        controller: passwordConfirmController,
                        label: tr('registrationInputPassConfirmLabel'),
                        validatorFunction: pwConfirmationValidator,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ConfirmationElevatedButton(
                    text: tr('registrationButton'),
                    onPressed: formButtonValidation,
                    foregroundColor: const Color.fromARGB(212, 183, 146, 14),
                    backgroundColor: const Color.fromARGB(255, 220, 219, 219),
                    btnTextStyle: registrationBtnTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}