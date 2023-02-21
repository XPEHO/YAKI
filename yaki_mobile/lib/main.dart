import 'package:flutter/material.dart';
import 'app.dart';
import 'package:easy_localization/easy_localization.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales:
          const [
            Locale('en', 'UK'),
            Locale('fr', 'FR')
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'UK'),
          child: const MyApp())
      );
}


