import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    // List of Swift methods that can be called from Flutter
    enum SwiftMethodCall: String {
        // scheduleNotificationSwift(timestamp: String, title: String, message: String)
        // timestamp follows ISO 8601 format
        case scheduleNotificationSwift = "scheduleNotificationSwift"
        // cancelAllNotificationsSwift()
        case cancelAllNotificationsSwift = "cancelAllNotificationsSwift"
    }

    // List of Flutter methods that can be called from Swift
    enum FlutterMethodCall: String {
        // Future<bool> notificationSetting() 
        case notificationSetting = "notificationSetting"
        // Future<void> channelLog(String message, String platformName)
        case channelLog = "channelLog"
    }

    static let flutterChannelName = "com.xpeho.yaki/notification"
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    var center: UNUserNotificationCenter?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        setupMethodChannel()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        // Request notification authorization if it hasn't been granted
        center = UNUserNotificationCenter.current()
        center?.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            self.channelLog("Notifications granted: \(granted)")
        }
        // Todo(Loucas): Remove this logging block. That's its only use for now.
        center?.getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                self.channelLog("Notifications not authorized")
            }
            self.channelLog("Notifications autorizationStatus: \(settings.authorizationStatus)")
        }
        // Todo(Loucas): Remove this
        channelLog("applicationDidBecomeActive")
        notificationSetting {
            self.channelLog("notificationSetting: \($0)")
        }
    }

    func getMethodChannel() -> FlutterMethodChannel {
        let controller: FlutterViewController? = window?.rootViewController as? FlutterViewController
        return FlutterMethodChannel(name: AppDelegate.flutterChannelName, binaryMessenger: controller!.binaryMessenger)
    }

    func setupMethodChannel() {
        let channel = getMethodChannel();
        
        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case SwiftMethodCall.scheduleNotificationSwift.rawValue:
                guard let args = call.arguments as? [String: Any] else {
                    self.channelLog("scheduleNotificationSwift: Invalid arguments")
                    result(FlutterError(
                        code: "invalid-arguments",
                        message: "Invalid arguments",
                        details: nil
                    ))
                    return
                }
                let timestamp = args["timestamp"] as! String
                let title = args["title"] as! String
                let message = args["message"] as! String

                self.scheduleNotification(timestamp: timestamp, title: title, message: message)
                result(nil)
            case SwiftMethodCall.cancelAllNotificationsSwift.rawValue:
                self.cancelAllNotifications()
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func channelLog(_ message: String) {
        print("channelLog")
        let platformName = "Swift"
        let channel = getMethodChannel();
        DispatchQueue.main.async {
            channel.invokeMethod(FlutterMethodCall.channelLog.rawValue, arguments: ["message": message, "platformName": platformName])
        }
    }
    
    private func isNotificationGranted(completion: @escaping (Bool) -> Void) {
        center?.getNotificationSettings { settings in
            let iOsSetting = settings.authorizationStatus
            self.notificationSetting { flutterSetting in
                if iOsSetting == .authorized && flutterSetting {
                    completion(true)
                }
                else {
                    completion(false)
                }
            }
        }
    }

    func scheduleNotification(timestamp: String, title: String, message: String) {
        // Todo(Loucas): Implement
        channelLog("scheduleNotificationSwift")
        channelLog("timestamp: \(timestamp), title: \(title), message: \(message)")
        var timestampDate = Date(iso8601Timestamp: timestamp)
        guard var timestampDate = timestampDate else {
            channelLog("scheduleNotificationSwift: Invalid timestamp")
            return
        }
        // timestampDate in utc -> local
        //timestampDate.addTimeInterval(Double(TimeZone.current.secondsFromGMT()))
        channelLog("timestampDate: \(timestampDate)\tcurrent date : \(Date())")
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],from: timestampDate)
        channelLog("components: \(components)")
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        channelLog("trigger: \(trigger)")
        let content = UNMutableNotificationContent()
        channelLog("content: \(content)")
        content.title = title
        content.body = message
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center?.add(request) { error in
            if let error = error {
                self.channelLog("scheduleNotificationSwift: \(error.localizedDescription)")
            } else {
                self.channelLog("\n\nscheduleNotificationSwift: Notification scheduled")
                    self.center?.getPendingNotificationRequests {
                        self.channelLog("Pending notifications: \($0)")
                    }
            }
        }
    }

    func cancelAllNotifications() {
        channelLog("cancelAllNotificationsSwift")
        center?.removeAllPendingNotificationRequests()
        center?.removeAllDeliveredNotifications()
    }    

    func notificationSetting(completion: @escaping (Bool) -> Void) {
        channelLog("notificationSetting")
        let channel = getMethodChannel();
        DispatchQueue.main.async {
            channel.invokeMethod(FlutterMethodCall.notificationSetting.rawValue, arguments: nil) { response in
                guard let responseBool = response as? Bool else {
                    self.channelLog("Swift notificationSetting response is not a bool")
                    completion(false)
                    return
                }
                completion(responseBool)
            }
        }
    }
}

// Note: We need to convert a timestamp in ISO 8601 format to a Date in scheduleNotificationSwift(timestamp: String, title: String, message: String)
extension Date {
    init?(iso8601Timestamp: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: iso8601Timestamp) {
            self = date
        } else {
            print("Error constructing Date from invalid timestamp format: \(iso8601Timestamp).\n Must follow format \"yyyy-MM-dd'T'HH:mm:ssZ\"")
            return nil
        }
    }
}
