package com.xpeho.yaki

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import java.time.ZoneId

class AlarmSchedulerImpl(private val context: Context) : AlarmScheduler {

    private val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager

    override fun schedule(item: AlarmItem) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (!alarmManager.canScheduleExactAlarms()) {
                val intent =
                        Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM).apply {
                            data = Uri.parse("package:${context.packageName}")
                        }
                context.startActivity(intent)
                return
            }
        }

        val intent =
                Intent(context, AlarmReceiver::class.java).apply {
                    putExtra("message", item.message)
                    putExtra("repeat", true)
                }
        alarmManager.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                item.time.atZone(ZoneId.systemDefault()).toEpochSecond() * 1000,
                PendingIntent.getBroadcast(
                        context,
                        item.hashCode(),
                        intent,
                        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
        )
    }

    override fun cancel(item: AlarmItem) {
        alarmManager.cancel(
                PendingIntent.getBroadcast(
                        context,
                        item.hashCode(),
                        Intent(context, AlarmReceiver::class.java),
                        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
        )
    }
}
