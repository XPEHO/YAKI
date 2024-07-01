import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
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
      case 'notificationSetting':
        return await notificationSetting();
      case 'channelLog':
        final message = call.arguments['message'] as String;
        final platformName = call.arguments['platformName'] as String;
        await channelLog(message, platformName);
        break;
      default:
        throw MissingPluginException();
    }
  });
}

//------------------------NATIVE CALL TO FLUTTER METHOD---------------------------

Future<void> channelLog(String message, String platformName) async {
  debugPrint("$platformName: $message");
}

// Todo(Loucas): Modify its usage un profile.dart to unschedule all notifications
// if the user does not want to receive them.

/// Check if the notifications are activated in the shared preferences
Future<bool> notificationSetting() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? areNotificationsActivated =
      prefs.getBool('areNotificationsActivated');
  return areNotificationsActivated ?? false;
}

// Todo(Loucas): Only use this from the flutter function that schedules notifications
/// Getter of the notification parameters stored in the translations
Map<String, dynamic> getNotificationParams() {
  return {
    'title': tr("notificationTitle"),
    'message': tr("notificationMessage"),
    'hour': 9,
    'minute': 0,
  };
}

// Todo(Loucas): Only use this from the flutter function that schedules notifications
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
  return declarationRepository.getDeclaredDays(userId);
}

//------------------------FLUTTER CALL TO NATIVE METHOD---------------------------

/// Check if notifications are permitted natively using the platform channel
Future<bool> areNotificationsPermitted() async {
  try {
    // Todo(Loucas): Redo this
    //return await platform.invokeMethod('areNotificationsPermitted');
  } on PlatformException catch (e) {
    debugPrint('Error: ${e.message}');
  }
  return true;
}

//    private func logAllNotifications() {
Future<void> logAllNotificationsSwift() async {
  return platform.invokeMethod('logAllNotificationsSwift');
}

/// Schedule a notification using the platform channel
/// @param timestamp: utc ISO8601 formated date string, format: "yyyy-MM-ddTHH:mm:ss.mmmuuuZ".
///   timestamp can be easily created using date.toUtc().toIso8601String()
/// @param title: The title of the notification
/// @param message: The message of the notification
Future<void> scheduleNotificationSwift(
  String timestamp,
  String title,
  String message,
) async {
  // Todo(Loucas): Add error handling for Dates < today()
  return await platform.invokeMethod(
    'scheduleNotificationSwift',
    {'timestamp': timestamp, 'title': title, 'message': message},
  );
}

Future<void> cancelAllNotificationsSwift() async {
  return platform.invokeMethod('cancelAllNotificationsSwift');
}

// ---- only about notifications ----

Future<void> scheduleReminderNotifications(
  int days,
  List<({int year, int month, int day})> declaredDays,
) async {
  debugPrint("scheduleReminderNotifications");
  const days = 60;
  final now = DateTime.now();
  final todayAt9am = DateTime(now.year, now.month, now.day, 9, 0, 0).toUtc();

  await cancelAllNotificationsSwift();
  for (var i = 1; i <= days; i++) {
    final date = todayAt9am.add(Duration(days: i));
    if (!declaredDays
        .contains((year: date.year, month: date.month, day: date.day))) {
      if (Platform.isIOS) {
        await scheduleNotificationSwift(
          date.toIso8601String(),
          "title", // Todo(Loucas): Change the messages to use `notificationTitle` and `notificationMessage` from `tr`
          "message ${date.toIso8601String()}",
        );
      }
    }
  }
  debugPrint("scheduleReminderNotifications done");
  if (Platform.isIOS && kDebugMode) {
    logAllNotificationsSwift();
  }
}
