package com.xpeho.yaki

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.graphics.Color
import androidx.core.app.NotificationCompat
import java.util.Calendar

const val ALARM_ID = "Alarm"

/** The receiver used to show a push notification when the alarm is triggered. */
class AlarmReceiver : BroadcastReceiver() {

  /**
   * This method is called when the alarm is triggered. We use it to show a push notification.
   *
   * @param context The context of the application
   * @param intent The intent used to trigger the alarm
   */
  override fun onReceive(context: Context?, intent: Intent?) {
    // Get the message from the intent
    if (intent == null) {
      return
    }
    val notificationTitle = intent.getStringExtra("title") ?: return
    val notificationMessage = intent.getStringExtra("message") ?: return

    // Make sure that the notification is not shown on weekends
    val currentDay = Calendar.getInstance().get(Calendar.DAY_OF_WEEK)
    if (currentDay == Calendar.SATURDAY || currentDay == Calendar.SUNDAY) {
      return
    }

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
