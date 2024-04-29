
/**
 Store the flutter channel, and channel methods names.
 The flutter channel names are used to communicate between Flutter and native iOS code.
 */
enum FlutterChannel: String {
    case name = "com.xpeho.yaki/notification"
    case cancelNotifications = "cancelNotifications"
    case scheduleNotifications = "scheduleNotifications"
    case getNotificationParams = "getNotificationParams"
    case areNotificationsPermitted = "areNotificationsPermitted"
}

/**
 This enum is used to store the keys for the notification parameters received from flutter channels (getNotificationParams).
 The notification parameters include the 
 hour, 
 minute, 
 title, 
 and message of the notification.
 */
enum NotificationParams: String {
    case hour = "hour"
    case minute = "minute"
    case title = "title"
    case message = "message"
}

/**
 This enum is used to store the keys for the user defaults.
 The user defaults keys are used to store the notification id.
 The notification authorization status.
 And the notification scheduled status.
 */
enum userDefaultsKeys: String {
    case notificationIds = "notificationIds"
    case isScheduleNotificationAuthorized = "isScheduleNotificationAuthorized"
    case isNotificationScheduled = "isNotificationScheduled"
}
