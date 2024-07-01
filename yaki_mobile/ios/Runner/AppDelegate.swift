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
        // logAllNotifications()
        case logAllNotificationsSwift = "logAllNotificationsSwift"
    }

    // List of Flutter methods that can be called from Swift
    enum FlutterMethodCall: String {
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
            case SwiftMethodCall.logAllNotificationsSwift.rawValue:
                self.logAllNotifications()
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func channelLog(_ message: String) {
        let platformName = "Swift"
        let channel = getMethodChannel();
        DispatchQueue.main.async {
            channel.invokeMethod(FlutterMethodCall.channelLog.rawValue, arguments: ["message": message, "platformName": platformName])
        }
    }

    private func logAllNotifications() {
        center?.getPendingNotificationRequests { requests in
            for (i, request) in requests.enumerated() {
                guard let trigger = request.trigger as? UNCalendarNotificationTrigger else {
                    continue
                }
                guard let nextDate = trigger.nextTriggerDate() else {
                    continue
                }
                let calendar = Calendar.current
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = formatter.string(from: nextDate)
                self.channelLog("Pending notification \(i+1): \n" 
                    + "\tid: \(request.identifier)\n"
                    + "\ttitle: \(request.content.title)\n"
                    + "\tbody: \(request.content.body)\n"
                    + "\tdate: \(dateString)")
            }
        }
    }
    
    func scheduleNotification(timestamp: String, title: String, message: String) {
        var timestampDate = Date(iso8601Timestamp: timestamp)
        guard var timestampDate = timestampDate else {
            channelLog("scheduleNotificationSwift: Invalid timestamp")
            return
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],from: timestampDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center?.add(request) { error in
            if let error = error {
                self.channelLog("scheduleNotificationSwift: \(error.localizedDescription)")
            } 
        }
    }

    func cancelAllNotifications() {
        center?.removeAllPendingNotificationRequests()
        center?.removeAllDeliveredNotifications()
    }    
}

// Note: We need to convert a timestamp in ISO 8601 format to a Date in 
// scheduleNotificationSwift(timestamp: String, title: String, message: String)
extension Date {
    init?(iso8601Timestamp: String) {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: iso8601Timestamp) {
            self = date
        } else {
            print("Error constructing Date from invalid timestamp format: \(iso8601Timestamp).\n Must follow format \"yyyy-MM-ddTHH:mm:ss.mmmuuuZ\"")
            return nil
        }
    }
}
