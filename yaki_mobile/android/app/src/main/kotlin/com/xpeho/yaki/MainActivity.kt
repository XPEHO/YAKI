package com.xpeho.yaki

import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import kotlinx.datetime.LocalTime
import kotlinx.datetime.TimeZone
import kotlinx.datetime.format.DateTimeComponents
import kotlinx.datetime.toInstant
import kotlinx.datetime.toLocalDateTime

const val APP_ID = "com.xpeho.yaki"

class MainActivity : FlutterActivity() {
  private val CHANNEL_NAME = "com.xpeho.yaki/notification"

  private fun methodChannel(): MethodChannel {
    val result = flutterEngine?.dartExecutor?.let { MethodChannel(it.binaryMessenger, CHANNEL_NAME) }
    if (result == null) {
      throw Error("methodChannel tried to be constructed before flutterEngine")
    }
    return result
  }

  private fun notificationManager(): NotificationManager {
    return getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
  }

  override fun onCreate(savedInstanceState: android.os.Bundle?) {
    super.onCreate(savedInstanceState)

    if(!notificationManager().areNotificationsEnabled()) {
      askNotificationsPermission()
    }
  }

  override fun onResume() {
    super.onResume()
  }

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    methodChannel().setMethodCallHandler {
        call,
        result ->
      when (call.method) {
        "scheduleNotificationKotlin" -> {
          val timestamp = call.argument<String>("timestamp")
          val title = call.argument<String>("title")
          val message = call.argument<String>("message")
          if (timestamp == null || title == null || message == null) { 
            result.error("scheduleNotificationKotlin", "timestamp, title or message is null", null)
            return@setMethodCallHandler
          }
          scheduleNotificationKotlin(timestamp, title, message)
          result.success(null)
        }
        "cancelAllNotificationsKotlin" -> {
          cancelAllNotificationsKotlin()
          result.success(null)
        }
        else -> result.notImplemented()
      }
    }
  }

  private fun scheduleNotificationKotlin(timestamp: String, title: String, message: String) {
    Log.d("scheduleNotificationKotlin", "scheduleNotificationKotlin")
    val components = DateTimeComponents.Formats.ISO_DATE_TIME_OFFSET.parse(timestamp)
    val utcInstant = components.toLocalDateTime().toInstant(TimeZone.UTC)
    val localTime = utcInstant.toLocalDateTime(TimeZone.currentSystemDefault())
    
    Log.d("scheduleNotificationKotlin", localTime.toString())

    notificationManager().cancelAll()
  }

  private fun cancelAllNotificationsKotlin() {
    Log.d("cancelAllNotificationsKotlin", "cancelAllNotificationsKotlin")
    notificationManager().cancelAll()
  }

  private fun askNotificationsPermission() {
    val intent =
        Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).apply {
          putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName)
        }
    context.startActivity(intent)
  }
}
