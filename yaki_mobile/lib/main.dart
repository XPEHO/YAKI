import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/app.dart';
import 'package:flutter/services.dart';
import 'package:yaki/presentation/state/dio/dio_interceptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Lock device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
      child: ProviderScope(
        overrides: await _overrides(),
        child: const YakiApp(),
      ),
    ),
  );

  // Notification channel
  const platform = MethodChannel('com.xpeho.yaki/notification');

  platform.setMethodCallHandler((MethodCall call) async {
    switch (call.method) {
      case 'areNotificationsActivated':
        return await areNotificationsActivated();
      case 'getNotificationParams':
        return getNotificationParams();
      default:
        throw MissingPluginException();
    }
  });
}

Future<List<Override>> _overrides() async {
  if (kDebugMode) {
    return [];
  }
  String serverCertificate =
      await rootBundle.loadString("assets/cer/server.cer");
  return [
    certificateProvider.overrideWithValue(
      serverCertificate,
    ),
  ];
}

Future<bool> areNotificationsActivated() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? areNotificationsActivated =
      prefs.getBool('areNotificationsActivated');
  return areNotificationsActivated ?? false;
}

Map<String, dynamic> getNotificationParams() {
  return {
    'title': tr("notificationTitle"),
    'message': tr("notificationMessage"),
    'hour': 9,
    'minute': 0,
  };
}
