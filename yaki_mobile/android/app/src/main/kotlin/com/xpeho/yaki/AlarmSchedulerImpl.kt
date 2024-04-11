package com.xpeho.yaki

import android.app.AlarmManager
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import java.time.ZoneId
import java.util.Calendar

class AlarmSchedulerImpl(private val context: Context) : AlarmScheduler {

  private val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
  private val notificationManager =
      context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
  private val alarmPendingIntentIdentifier = "com.xpeho.yaki.DAILY_DECLARATION_ALARM"

  override fun schedule(item: AlarmItem) {
    // Check if the device supports exact alarms
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
      return
    }

    // Schedule alarm
    val zonedDateTime = item.time.atZone(ZoneId.systemDefault())
    val calendar =
        Calendar.getInstance().apply { timeInMillis = zonedDateTime.toInstant().toEpochMilli() }

    if (calendar.timeInMillis < System.currentTimeMillis()) {
      calendar.add(Calendar.DAY_OF_YEAR, 1)
    }

    val intent =
        Intent(context, AlarmReceiver::class.java).apply { putExtra("message", item.message) }
    val pendingIntent =
        PendingIntent.getBroadcast(
            context,
            alarmPendingIntentIdentifier.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

    alarmManager.setInexactRepeating(
        AlarmManager.RTC_WAKEUP,
        calendar.timeInMillis,
        AlarmManager.INTERVAL_DAY, // 10 * 1000,
        pendingIntent
    )
  }

  override fun cancel(item: AlarmItem) {
    // Cancel an alarm
    val intent =
        Intent(context, AlarmReceiver::class.java).apply { putExtra("message", item.message) }
    val pendingIntent =
        PendingIntent.getBroadcast(
            context,
            alarmPendingIntentIdentifier.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    alarmManager.cancel(pendingIntent)
  }
}
