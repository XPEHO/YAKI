package com.xpeho.yaki

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat
import java.time.LocalDateTime

class AlarmReceiver : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
                val message = intent?.getStringExtra("message") ?: return

                if (context != null) {
                        // Show a push notification
                        val notificationManager =
                                        context.getSystemService(Context.NOTIFICATION_SERVICE) as
                                                        NotificationManager

                        val channel =
                                        NotificationChannel(
                                                        "Alarm",
                                                        "Alarm",
                                                        NotificationManager.IMPORTANCE_DEFAULT
                                        )
                        notificationManager.createNotificationChannel(channel)

                        val notification =
                                        NotificationCompat.Builder(context, "Alarm")
                                                        .setContentTitle("Reminder")
                                                        .setContentText(message)
                                                        .setSmallIcon(R.mipmap.ic_launcher)
                                                        .build()

                        notificationManager.notify(1, notification)

                        // Define the next alarm
                        if (intent.getBooleanExtra("repeat", false)) {
                                AlarmSchedulerImpl(context = context)
                                                .schedule(
                                                                AlarmItem(
                                                                                time =
                                                                                                LocalDateTime.now()
                                                                                                                .plusDays(
                                                                                                                                1
                                                                                                                ),
                                                                                message =
                                                                                                "It's time to do your daily declaration!"
                                                                )
                                                )
                        }
                }
        }
}
