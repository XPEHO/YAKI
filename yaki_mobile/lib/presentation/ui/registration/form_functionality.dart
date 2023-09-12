import 'package:easy_localization/easy_localization.dart';

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
    r'^(?=.*?[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[$£€µù^&§+=:;.?,()é!@#\><*~"%\-_/\[\]\{\}\|ç]).{10}',
  );
  if (value != null && value.isEmpty) {
    return tr('registrationInputPasswordError1');
  }

  if (!passwordRegex.hasMatch(value!)) {
    return tr('registrationInputPasswordError2');
  }
  return null;
}

String? pwConfirmationValidator(String? value, String passwordController) {
  if (value != null && value.isEmpty) {
    return tr('registrationInputPassConfirmError1');
  }
  if (passwordController != value) {
    return tr('registrationInputPassConfirmError2');
  }
  return null;
}

String capitalize(String s) {
  //first letter uppercase only
  return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
}
