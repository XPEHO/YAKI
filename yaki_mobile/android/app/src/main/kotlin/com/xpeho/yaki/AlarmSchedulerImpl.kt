package com.xpeho.yaki

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import java.time.ZoneId
import java.util.Calendar

class AlarmSchedulerImpl(private val context: Context) : AlarmScheduler {
  /** The alarm manager used to schedule the alarms */
  private val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
  /** The identifier of the pending intent used to schedule and cancel the alarms */
  private val alarmPendingIntentIdentifier = "com.xpeho.yaki.DAILY_DECLARATION_ALARM"

  /**
   * Schedule an alarm every day.
   *
   * @param item The alarm item to define the properties of the notification
   */
  override fun schedule(item: AlarmItem) {
    // Check if the device supports exact alarms
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
      return
    }

    // The time of the alarm defined in the local time zone
    val zonedDateTime = item.time.atZone(ZoneId.systemDefault())
    // The calendar used to schedule the alarm
    val calendar =
        Calendar.getInstance().apply { timeInMillis = zonedDateTime.toInstant().toEpochMilli() }
    // If the alarm time is in the past, we schedule it for the next day
    if (calendar.timeInMillis < System.currentTimeMillis()) {
      calendar.add(Calendar.DAY_OF_YEAR, 1)
    }

    // The intent used to schedule the alarm
    val intent =
        Intent(context, AlarmReceiver::class.java).apply {
          putExtra("title", item.title)
          putExtra("message", item.message)
        }
    // The pending intent used to schedule the alarm
    val pendingIntent =
        PendingIntent.getBroadcast(
            context,
            alarmPendingIntentIdentifier.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

    // Schedule the alarm
    alarmManager.setInexactRepeating(
        AlarmManager.RTC_WAKEUP,
        calendar.timeInMillis,
        AlarmManager.INTERVAL_DAY,
        pendingIntent
    )

    // Get the shared preferences
    val sharedPreferences = context.getSharedPreferences(APP_ID, Context.MODE_PRIVATE)

    // Define as scheduled in the shared preferences
    with(sharedPreferences.edit()) {
      putBoolean("areNotificationsScheduled", true)
      apply()
    }
  }

  /**
   * Cancel an alarm.
   *
   * @param item The alarm item to define the properties of the notification
   */
  override fun cancel(item: AlarmItem) {
    // The intent used to schedule the alarm
    val intent =
        Intent(context, AlarmReceiver::class.java).apply {
          putExtra("title", item.title)
          putExtra("message", item.message)
        }
    // The pending intent used to schedule the alarm
    val pendingIntent =
        PendingIntent.getBroadcast(
            context,
            alarmPendingIntentIdentifier.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    // Cancel the alarm
    alarmManager.cancel(pendingIntent)

    // Get the shared preferences
    val sharedPreferences = context.getSharedPreferences(APP_ID, Context.MODE_PRIVATE)

    // Define as not scheduled in the shared preferences
    with(sharedPreferences.edit()) {
      putBoolean("areNotificationsScheduled", false)
      apply()
    }
  }
}
