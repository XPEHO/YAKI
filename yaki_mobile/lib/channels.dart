import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

const platform = MethodChannel('com.xpeho.yaki/notification');

void initChannels() {
  // Notification channel
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

//------------------------NATIVE CALL TO FLUTTER METHOD---------------------------

/// Check if the notifications are activated in the shared preferences
Future<bool> areNotificationsActivated() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? areNotificationsActivated =
      prefs.getBool('areNotificationsActivated');
  return areNotificationsActivated ?? false;
}

/// Getter of the notification parameters stored in the translations
Map<String, dynamic> getNotificationParams() {
  return {
    'title': tr("notificationTitle"),
    'message': tr("notificationMessage"),
    'hour': 9,
    'minute': 0,
  };
}

//------------------------FLUTTER CALL TO NATIVE METHOD---------------------------

/// Schedule notifications natively using the platform channel
void scheduleNotifications() async {
  try {
    await platform.invokeMethod('scheduleNotifications');
  } on PlatformException catch (e) {
    debugPrint('Error: ${e.message}');
  }
}

/// Cancel notifications natively using the platform channel
void cancelNotifications() async {
  try {
    await platform.invokeMethod('cancelNotifications');
  } on PlatformException catch (e) {
    debugPrint('Error: ${e.message}');
  }
}

/// Check if notifications are permitted natively using the platform channel
Future<bool> areNotificationsPermitted() async {
  try {
    return await platform.invokeMethod('areNotificationsPermitted');
  } on PlatformException catch (e) {
    debugPrint('Error: ${e.message}');
  }
  return true;
}
