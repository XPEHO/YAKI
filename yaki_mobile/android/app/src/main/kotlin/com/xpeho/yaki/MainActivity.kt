package com.xpeho.yaki

import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.LocalTime

class MainActivity : FlutterActivity() {
  private val CHANNEL = "com.xpeho.yaki/notification"
  private lateinit var alarmScheduler: AlarmSchedulerImpl
  private val alarmItem =
      AlarmItem(
          time =
              LocalDateTime.of(
                  LocalDate.now(),
                  LocalTime.of(9, 0)
              ), // LocalDateTime.now().plusSeconds(10),
          message = "It's time to do your daily declaration!"
      )

  override fun onCreate(savedInstanceState: android.os.Bundle?) {
    super.onCreate(savedInstanceState)
    alarmScheduler = AlarmSchedulerImpl(context = this)
  }

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call,
        result ->
      when (call.method) {
        "scheduleNotifications" -> {
          scheduleNotifications()
          result.success(null)
        }
        "cancelNotifications" -> {
          cancelNotifications()
          result.success(null)
        }
        "arePermissionsEnabled" -> {
          result.success(areNotificationsPermitted())
        }
        else -> result.notImplemented()
      }
    }
  }

  private fun scheduleNotifications() {
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
      return
    }

    // Ask notification permission if needed
    askNotificationsPermissionIfNeeded()

    // Start a new thread to check the permissions status
    Thread {
          while (!areNotificationsPermitted()) {
            Thread.sleep(5000) // Wait for 5 second
          }
          // Schedule the alarm after the permission is granted
          alarmScheduler.schedule(alarmItem)
        }
        .start()
  }

  private fun cancelNotifications() {
    alarmScheduler.cancel(alarmItem)
  }

  private fun areNotificationsPermitted(): Boolean {
    val notificationManager =
        this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    return notificationManager.areNotificationsEnabled()
  }

  private fun askNotificationsPermissionIfNeeded() {
    if (!areNotificationsPermitted()) {
      val intent =
          Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).apply {
            putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName)
          }
      context.startActivity(intent)
    }
  }
}
