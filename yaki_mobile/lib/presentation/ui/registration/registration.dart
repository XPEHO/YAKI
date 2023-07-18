//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/ui/shared/views/input_registration_page.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

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

  final _formKey = GlobalKey<FormState>();

  void formButtonValidation() {
    if (_formKey.currentState!.validate()) {
      debugPrint("c'est validé, outside function");
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Ce champ doit être renseigné";
    }
    return null;
  }

  String? emailValidator(String? value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9-_.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (value != null && !emailRegex.hasMatch(value)) {
      return "Le format de l'email n'est pas correct";
    }
    return null;
  }

  //&&

  String? passwordValidator(String? value) {
    final passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[$£ù^&§+=:;.?,()é!@#\><*~]).{10}',
    );

    if (!passwordRegex.hasMatch(value!)) {
      return "Password minimum, 10 caractères : \n - Une majuscule et minuscule \n - Un chiffre \n - Un caractère spécial";
    }
    return null;
  }

  String? passwordConfirmation(String? value) {}

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
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 30),
                  child: Text(
                    "Creation de compte",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputRegistration(
                        controller: firstNameController,
                        label: "Entrez votre nom :",
                        validatorFunction: nameValidator,
                      ),
                      InputRegistration(
                        controller: lastNameController,
                        label: "Entrez votre prenom :",
                        validatorFunction: nameValidator,
                      ),
                      InputRegistration(
                        controller: emailController,
                        label: "Entrez votre email :",
                        validatorFunction: emailValidator,
                      ),
                      InputRegistration(
                        controller: passwordController,
                        label: "Créer votre password :",
                        validatorFunction: passwordValidator,
                      ),
                      InputRegistration(
                        controller: passwordConfirmController,
                        label: "Confirmer votre password :",
                        validatorFunction: passwordValidator,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(212, 183, 146, 14),
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 220, 219, 219),
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 50,
                        left: 50,
                      ),
                    ),
                    onPressed: formButtonValidation,
                    child: const Text(
                      "register",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
