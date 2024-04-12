import UIKit

struct Notification {
    var hours: Int
    var minutes: Int
    var messageTitle: String
    var messageBody: String
}

/**
 This struct is used to store the notification settings.
 The notification settings include the hours and minutes for the notification, the title and body of the notification message.
 */
var notificationSettings = Notification(
    hours: 9,
    minutes: 0,
    messageTitle: "Reminder",
    messageBody: "fill out your YAKI declaration!")


extension AppDelegate {    
    var notificationId: String? {
        get {
            return UserDefaults.standard.string(forKey: userDefaultsKeys.notificationId.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsKeys.notificationId.rawValue)
        }
    }
    
    var isScheduleNotificationAuthorized: Bool {
        get {
            return UserDefaults.standard.bool(forKey: userDefaultsKeys.isScheduleNotificationAuthorized.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsKeys.isScheduleNotificationAuthorized.rawValue)    
        }
    }
    var isNotificationScheduled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: userDefaultsKeys.isNotificationScheduled.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsKeys.isNotificationScheduled.rawValue)
        }
    }
}
