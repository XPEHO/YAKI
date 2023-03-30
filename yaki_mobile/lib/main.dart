import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      // ProviderScope is a widget that stores the state of all the providers we create.
      // it wrap the root widget.

      // provider is described it as a mix between State Management and Dependency Injection
      // its a bridge from widget to data stored in state. It make possible to use any declared provider globally
      // Any widget(converted as consumerWidget, for the statelessWidget)
      // will have access to the WidgetRef objet, making the widget able to have access to any provider, so state.
      child: const ProviderScope(child: YakiApp()),
    ),
  );
}
