import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/state/providers/password_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/features/registration/form_functionality.dart';
import 'package:yaki/presentation/features/registration/view/registration_snackbar.dart';
import 'package:yaki_ui/yaki_ui.dart';

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
  bool _isLoading = false;

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
  Future passwordChangeValidation({
    required Function(bool) setLoading,
  }) async {
    setLoading(true); //show the loader
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
        setLoading(false);
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/yaki_basti_icon.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: size.height / 20),
                Text(
                  tr('changePasswordPageTitle'),
                  style: registrationPageTitleTextStyle(),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputText(
                        type: InputTextType.password,
                        controller: currentPassword,
                        label: tr('changePasswordPageOldPW'),
                        validator: passwordValidator,
                      ),
                      const SizedBox(height: 20),
                      InputText(
                        type: InputTextType.password,
                        label: tr('changePasswordPageNewPW'),
                        controller: newPassword,
                        validator: passwordValidator,
                      ),
                      const SizedBox(height: 20),
                      InputText(
                        type: InputTextType.password,
                        label: tr('changePasswordPageNewPWConfirm'),
                        controller: newPasswordConfirmation,
                        validator: (value) =>
                            pwConfirmationValidator(value, newPassword.text),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading && _formKey.currentState!.validate()
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          strokeWidth: 5,
                          semanticsLabel: 'Loading',
                        ),
                      )
                    : Button(
                        buttonHeight: 72,
                        text: tr('changePasswordPageConfimButton'),
                        onPressed: () => passwordChangeValidation(
                          setLoading: (bool isLoading) =>
                              setState(() => _isLoading = isLoading),
                        ),
                      ),
                const SizedBox(height: 20),
                Button.secondary(
                  buttonHeight: 64,
                  text: tr('registrationCancelButton'),
                  onPressed: () => context.go("/profile"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
