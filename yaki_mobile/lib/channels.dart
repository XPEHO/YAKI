import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';

const platform = MethodChannel('com.xpeho.yaki/notification');

void initChannels() {
  // Notification channel
  platform.setMethodCallHandler((MethodCall call) async {
    switch (call.method) {
      case 'areNotificationsActivated':
        return await areNotificationsActivated();
      case 'getNotificationParams':
        return getNotificationParams();
      case 'getDeclaredDays':
        return await getDeclaredDays();
      case 'isDeclaredToday':
        return await isDeclaredToday();
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

/// send the list of all declared days for the current user to Swift
/// Note: We have to retrieve all of them because iOS requires to schedule
/// notifications in advance.
Future<List<String>> getDeclaredDays() async {
  final provider = ProviderContainer();
  final declarationRepository = provider.read(declarationRepositoryProvider);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final int? userId = prefs.getInt("userId");
  if (userId == null) {
    return Future.value([]);
  }
  debugPrint("getDeclaredDays, userId : $userId");
  return declarationRepository.getDeclaredDays(userId);
}

/// check that the user has declared himself today.
Future<bool> isDeclaredToday() async {
  final provider = ProviderContainer();
  final declarationRepository = provider.read(declarationRepositoryProvider);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final int? userId = prefs.getInt("userId");
  if (userId == null) {
    return Future.value(false);
  }
  debugPrint("isDeclaredToday, userId : $userId");
  debugPrint(
    "isDeclaredToday, today : ${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
  );
  final declaredDays = await declarationRepository.getDeclaredDays(userId);
  final today = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final closestDay = declaredDays.reduce((a, b) => a.compareTo(b) <= 0 ? a : b);
  debugPrint("isDeclaredToday, closestDay : $closestDay");
  debugPrint("isDeclaredToday, function result : ${closestDay == today}");

  return Future.value(closestDay == today);
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
