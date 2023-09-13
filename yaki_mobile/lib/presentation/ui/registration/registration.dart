import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/user_registration_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/registration/form_functionality.dart';
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

  // when press register button
  Future<void> formButtonValidation() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(userRegisterRepositoryProvider).registerUser(
            firstname: firstNameController.text,
            lastname: lastNameController.text,
            email: emailController.text,
            password: passwordConfirmController.text,
          );

      // after registration response get "isRegistered" value, being the object send from mobile API
      // confirming the registration was a success (no need others data)
      final String registrationResult =
          ref.watch(userRegisterRepositoryProvider).status;

      // depending of true of false (will be changed to true only if code200) change snachbar message and message color
      if (registrationResult == "OK") {
        showSnackBar(
          content: tr("registrationSnackSuccess"),
          textStyle: registrationSnackTextStyle(
            textColor: const Color.fromARGB(255, 82, 251, 45),
          ),
          actionLabel: tr('registrationSnackValidation'),
          barAction: () {},
        );
        // ignore: use_build_context_synchronously
        context.go('/');
      } else if (registrationResult == "registrationFailed") {
        showSnackBar(
          content: tr("registrationSnackError"),
          textStyle: registrationSnackTextStyle(
            textColor: const Color.fromARGB(255, 245, 33, 33),
          ),
          actionLabel: tr('registrationCancelButton'),
          barAction: () {},
        );
      } else if (registrationResult == "registrationInputEmailError") {
        showSnackBar(
          content: tr('registrationCancelButton'),
          textStyle: registrationSnackTextStyle(
            textColor: const Color.fromARGB(255, 245, 33, 33),
          ),
          actionLabel: "Ok",
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
                        textInputAction: TextInputAction.next,
                        controller: firstNameController,
                        label: tr('registrationInputFirstnameLabel'),
                        validatorFunction: nameValidator,
                        isShown: false,
                        onChange: (value) {
                          firstNameController.value = TextEditingValue(
                            text: capitalize(value),
                            selection: firstNameController.selection,
                          );
                        }, // textCapitalization: capitalize,
                      ),
                      InputRegistration(
                        textInputAction: TextInputAction.next,
                        controller: lastNameController,
                        label: tr('registrationInputLastnameLabel'),
                        validatorFunction: nameValidator,
                        isShown: false,
                        onChange: (value) {
                          lastNameController.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: lastNameController.selection,
                          );
                        }, // textCapitalization: toUpperCase,
                      ),
                      InputRegistration(
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        label: tr('registrationInputEmailLabel'),
                        validatorFunction: emailValidator,
                        isShown: false,
                        // textCapit,
                      ),
                      InputRegistration(
                        textInputAction: TextInputAction.next,
                        controller: passwordController,
                        label: tr('registrationInputPasswordLabel'),
                        validatorFunction: passwordValidator,
                        isShown: true,
                      ),
                      InputRegistration(
                        textInputAction: TextInputAction.done,
                        controller: passwordConfirmController,
                        label: tr('registrationInputPassConfirmLabel'),
                        validatorFunction: (value) => pwConfirmationValidator(
                          value,
                          passwordController.text,
                        ),
                        isShown: true,
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
                Padding(
                  padding: const EdgeInsets.only(top: 40),
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
        ),
      ),
    );
  }
}
