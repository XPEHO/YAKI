package com.xpeho.yaki

import io.flutter.plugin.common.MethodChannel
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.util.Log
import androidx.core.app.NotificationCompat
import java.util.Calendar
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor

const val ALARM_ID = "Alarm"
const val CHANNEL_NAME = "com.xpeho.yaki/notification"

/** The receiver used to show a push notification when the alarm is triggered. */
class AlarmReceiver : BroadcastReceiver() {
    /**
     * This method is called when the alarm is triggered. We use it to show a push notification.
     *
     * @param context The context of the application
     * @param intent The intent used to trigger the alarm
     */
    override fun onReceive(context: Context?, intent: Intent?) {
        Log.d("AlarmReceiver", "Alarm received")

        // Make sure that the notification is not shown on weekends
        val currentDay = Calendar.getInstance().get(Calendar.DAY_OF_WEEK)
        if (currentDay == Calendar.SATURDAY || currentDay == Calendar.SUNDAY) {
            return
        }

        Log.d("AlarmReceiver", "Setup Flutter engine")
        // Initialize the Flutter engine.
        val flutterEngine = context?.let { FlutterEngine(it) }

        // Start executing Dart code to initialize the Flutter engine.
        flutterEngine?.dartExecutor?.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        Log.d("AlarmReceiver", "Invoke Flutter method")
        // Use the MethodChannel to invoke a method on the Flutter side.
        flutterEngine?.dartExecutor?.let { MethodChannel(it.binaryMessenger, CHANNEL_NAME) }
            ?.invokeMethod("isDeclaredToday", null, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    // Handle success.
                    Log.d("AlarmReceiver", "Invoke success")
                    Log.d("AlarmReceiver", result.toString())
                    if (result as? Boolean == true) {

                        return
                    } else {
                        showNotification(context, intent)
                    }
                }

                override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    // Handle error.
                    Log.d("AlarmReceiver", "Invoke error")
                    Log.d("AlarmReceiver", errorMessage.toString())
                }

                override fun notImplemented() {
                    // Handle method not implemented in Flutter.
                    Log.d("AlarmReceiver", "Invoke notImplemented")
                }
            })
    }

  /**
   * Show a push notification.
   *
   * @param context The context of the application
   * @param title The title of the notification
   * @param message The message of the notification
   */
  private fun showNotification(context: Context?, intent: Intent?){
    // Get the message from the intent
    if (intent == null) {
      return
    }
    val notificationTitle = intent.getStringExtra("title") ?: return
    val notificationMessage = intent.getStringExtra("message") ?: return

    // Check if the context is not null
    if (context != null) {
      // Create the notification channel
      val notificationManager =
          context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

      val channel = NotificationChannel(ALARM_ID, ALARM_ID, NotificationManager.IMPORTANCE_DEFAULT)
      notificationManager.createNotificationChannel(channel)

      // Set the intent to launch the app
      val launchAppIntent =
          Intent(context, MainActivity::class.java).apply { flags = Intent.FLAG_ACTIVITY_NEW_TASK }
      val launchAppPendingIntent =
          PendingIntent.getActivity(
              context,
              0,
              launchAppIntent,
              PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
          )

      // Create the notification
      val notification =
          NotificationCompat.Builder(context, ALARM_ID)
              .setContentTitle(notificationTitle)
              .setContentText(notificationMessage)
              .setSmallIcon(R.mipmap.ic_notif)
              .setColor(Color.parseColor("#FF936B")) // Set the color
              .setContentIntent(launchAppPendingIntent) // Set the PendingIntent
              .setAutoCancel(true) // Automatically remove the notification when the user taps it
              .build()

      // Show the notification
      notificationManager.notify(1, notification)
    }
  }
}
