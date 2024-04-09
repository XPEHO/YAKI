package com.xpeho.yaki

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDateTime

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.xpeho.yaki/notification"

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
                else -> result.notImplemented()
            }
        }
    }

    private fun scheduleNotifications() {
        AlarmSchedulerImpl(context = this)
                .schedule(
                        AlarmItem(
                                time = LocalDateTime.now().withHour(9).withMinute(0).withSecond(0),
                                message = "It's time to do your daily declaration!"
                        )
                )
    }

    private fun cancelNotifications() {
        AlarmSchedulerImpl(context = this)
                .cancel(
                        AlarmItem(
                                time = LocalDateTime.now().withHour(9).withMinute(0).withSecond(0),
                                message = "It's time to do your daily declaration!"
                        )
                )
    }
}
