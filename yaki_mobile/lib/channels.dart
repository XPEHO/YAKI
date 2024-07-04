import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';

const platform = MethodChannel('com.xpeho.yaki/notification');

void initChannels() {
  // Notification channel
  platform.setMethodCallHandler((MethodCall call) async {
    switch (call.method) {
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

// Todo(Loucas): In profile.dart, unschedule all notifications
// if the user does not want to receive them.

/// Check if the notifications are activated in the shared preferences
Future<bool> notificationSetting() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? areNotificationsActivated =
      prefs.getBool('areNotificationsActivated');
  return areNotificationsActivated ?? false;
}

//------------------------FLUTTER CALL TO NATIVE METHOD---------------------------

typedef DayRecord = ({int year, int month, int day});

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
  return await platform.invokeMethod(
    'scheduleNotificationSwift',
    {'timestamp': timestamp, 'title': title, 'message': message},
  );
}

Future<void> cancelAllNotificationsSwift() async {
  return platform.invokeMethod('cancelAllNotificationsSwift');
}

//    private func logAllNotifications() {
Future<void> logAllNotificationsSwift() async {
  return platform.invokeMethod('logAllNotificationsSwift');
}

Future<void> scheduleNotificationKotlin(
  String timestamp,
  String title,
  String message,
) async {
  return platform.invokeMethod(
    'scheduleNotificationKotlin',
    {'timestamp': timestamp, 'title': title, 'message': message},
  );
}

Future<void> cancelAllNotificationsKotlin() async {
  return platform.invokeMethod('cancelAllNotificationsKotlin');
}

Future<void> logAllNotificationsKotlin() async {
  return platform.invokeMethod('logAllNotificationsKotlin');
}

// ---- only about notifications ----

List<DayRecord> listDayRecordsFromGouvFrJson(String jsonString) {
  final Map<String, dynamic> holidaysJson;
  try {
    holidaysJson = jsonDecode(jsonString);
  } catch (e) {
    debugPrint("Failed to parse file: $e");
    rethrow;
  }

  List<DayRecord> holidays = [];
  try {
    holidays = holidaysJson.entries
        .map((entry) => entry.key.split('-'))
        .map(
          (entry) => (
            year: entry[0],
            month: entry[1],
            day: entry[2],
          ),
        )
        .map(
          (e) => (
            year: int.parse(e.year),
            month: int.parse(e.month),
            day: int.parse(e.day),
          ),
        )
        .toList();
  } catch (e) {
    debugPrint("Failed to parse date string: $e");
    rethrow;
  }

  return holidays;
}

/*
  Data sources: The declared days are retrieved through the DeclarationRepository from the Express.js Backend talking to PostgreSQL.
  The userId is coming from the sharedPreferences.
  Todo(Loucas): 
    - [x] Exclude weekends
    - [x] Exclude holidays in metropolitan France
      - https://calendrier.api.gouv.fr/jours-feries/metropole.json
        - [x] Get from a local file
        - [x] If the current year is not found in said file, query the API
        - [ ] Add to the documentation: instructions to refresh the local file
           - [ ] Prerequisite: Find the location to put this information in the documentation
    - [ ] Refactor this whole thing into its own classes and files
    - [ ] Android - create scheduleNotificationKotlin(timestamp: String, title: String, message: String)
    - [ ] Flutter - Also call this function when a new declaration has occured
*/
Future<void> scheduleReminderNotifications(
  int days,
) async {
  if (!await notificationSetting()) {
    debugPrint("Notifications are not activated");
    return;
  }

  // retrieve declared days
  final provider = ProviderContainer();
  final declarationRepository = provider.read(declarationRepositoryProvider);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? userId = prefs.getInt("userId");
  if (userId == null) {
    debugPrint("userId is null");
    return;
  }
  List<String> declaredDaysStrings =
      await declarationRepository.getDeclaredDays(userId);
  List<DayRecord> declaredDays = declaredDaysStrings
      .map(
        (e) => e.split('-').map((e) => int.parse(e)).toList(),
      )
      .map((e) => (year: e[0], month: e[1], day: e[2]))
      .toList();

  debugPrint("scheduleReminderNotifications"); //todo remove
  final now = DateTime.now();
  final todayAt9am = DateTime(now.year, now.month, now.day, 9, 0, 0).toUtc();

  String fileLocation = 'assets/public_holidays/public_holidays.json';
  String fileContent;
  try {
    fileContent = await rootBundle.loadString(fileLocation);
  } catch (e) {
    debugPrint("Failed to load file: $e");
    return;
  }

  List<DayRecord> holidays = listDayRecordsFromGouvFrJson(fileContent);

  // todo: remove temporary test
  holidays = [];

  if (!holidays.map((e) => e.year).contains(now.year)) {
    debugPrint("Fetching holidays from API"); // todo remove logging
    // fetch the api https://calendrier.api.gouv.fr/jours-feries/metropole.json

    String jsonResponse;
    try {
      HttpClient client = HttpClient();
      var request = await client.getUrl(
        Uri.parse(
          'https://calendrier.api.gouv.fr/jours-feries/metropole.json',
        ),
      );
      var response = await request.close();
      jsonResponse = await response.transform(utf8.decoder).join();
    } catch (e) {
      debugPrint("Failed to fetch holidays: $e");
      return;
    }
    holidays = listDayRecordsFromGouvFrJson(jsonResponse);
  }

  if (Platform.isIOS) {
    await cancelAllNotificationsSwift();
  }
  if (Platform.isAndroid) {
    await cancelAllNotificationsKotlin();
  }
  for (var i = 1; i <= days; i++) {
    final date = todayAt9am.add(Duration(days: i));

    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      debugPrint("Date $date is a Saturday or Sunday"); // todo remove logging
      continue;
    }
    var isHoliday =
        holidays.contains((year: date.year, month: date.month, day: date.day));
    if (isHoliday) {
      debugPrint(
        "Date $date is a French metropolitan holiday",
      ); // todo remove logging
      continue;
    }

    if (!declaredDays
        .contains((year: date.year, month: date.month, day: date.day))) {
      if (Platform.isIOS) {
        await scheduleNotificationSwift(
          date.toIso8601String(),
          tr("notificationTitle"),
          tr("notificationMessage"),
        );
      }
      if (Platform.isAndroid) {
        await scheduleNotificationKotlin(
          date.toIso8601String(),
          tr("notificationTitle"),
          tr("notificationMessage"),
        );
      }
    }
  }
  debugPrint("scheduleReminderNotifications done"); // todo remove logging
  if (kDebugMode) {
    if (Platform.isIOS) {
      logAllNotificationsSwift();
    }
    if (Platform.isAndroid) {
      //logAllNotificationsKotlin();
    }
  }
}
