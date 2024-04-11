package com.xpeho.yaki

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.graphics.Color
import androidx.core.app.NotificationCompat

class AlarmReceiver : BroadcastReceiver() {
  override fun onReceive(context: Context?, intent: Intent?) {
    // Get the message from the intent
    val message = intent?.getStringExtra("message") ?: return

    if (context != null) {
      // Show a push notification
      val notificationManager =
          context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

      val channel = NotificationChannel("Alarm", "Alarm", NotificationManager.IMPORTANCE_DEFAULT)
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

      val notification =
          NotificationCompat.Builder(context, "Alarm")
              .setContentTitle("Reminder")
              .setContentText(message)
              .setSmallIcon(R.mipmap.ic_notif)
              .setColor(Color.parseColor("#FF936B")) // Set the color
              .setContentIntent(launchAppPendingIntent) // Set the PendingIntent
              .setAutoCancel(true) // Automatically remove the notification when the user taps it
              .build()

      notificationManager.notify(1, notification)
    }
  }
}
