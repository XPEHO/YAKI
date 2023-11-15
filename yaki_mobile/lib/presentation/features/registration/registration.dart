import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/user_registration_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/features/registration/form_functionality.dart';
import 'package:yaki/presentation/features/registration/view/registration_snackbar.dart';
import 'package:yaki_ui/yaki_ui.dart';

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
            email: emailController.text.toLowerCase().trim(),
            password: passwordConfirmController.text.trim(),
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
        context.go('/authentication');
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/yaki_basti_icon.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: size.height / 20),
                Text(
                  tr('registrationPageTitle'),
                  style: registrationPageTitleTextStyle(),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InputText(
                        type: InputTextType.email,
                        label: tr('registrationInputFirstnameLabel'),
                        controller: firstNameController,
                        readOnly: false,
                        validator: nameValidator,
                        onChange: (value) {
                          firstNameController.value = TextEditingValue(
                            text: capitalize(value),
                            selection: firstNameController.selection,
                          );
                        }, // textCapitalization: capitalize,
                      ),
                      const SizedBox(height: 20),
                      InputText(
                        type: InputTextType.email,
                        label: tr('registrationInputLastnameLabel'),
                        controller: lastNameController,
                        readOnly: false,
                        validator: nameValidator,
                        onChange: (value) {
                          lastNameController.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: lastNameController.selection,
                          );
                        }, // textCapitalization: toUpperCase,
                      ),
                      const SizedBox(height: 20),
                      InputText(
                        type: InputTextType.email,
                        label: tr('registrationInputEmailLabel'),
                        controller: emailController,
                        readOnly: false,
                        validator: emailValidator,
                        // textCapit,
                      ),
                      const SizedBox(height: 20),
                      InputText(
                        type: InputTextType.password,
                        label: tr('registrationInputPasswordLabel'),
                        controller: passwordController,
                        readOnly: false,
                        validator: passwordValidator,
                      ),
                      const SizedBox(height: 20),
                      InputText(
                        type: InputTextType.password,
                        label: tr('registrationInputPassConfirmLabel'),
                        controller: passwordConfirmController,
                        readOnly: false,
                        validator: (value) => pwConfirmationValidator(
                          value,
                          passwordController.text,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  buttonHeight: 72,
                  text: tr('registrationButton'),
                  onPressed: formButtonValidation,
                ),
                const SizedBox(height: 20),
                Button.secondary(
                  buttonHeight: 64,
                  text: tr('registrationCancelButton'),
                  onPressed: () => context.go("/authentication"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
