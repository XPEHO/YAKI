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
    }

    static let flutterChannelName = "com.xpeho.yaki/notification"
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

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
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Notifications granted: \(granted)")
        }
        // Todo(Loucas): Remove this logging block. That's its only use for now.
        center.getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                print("Notifications not authorized")
            }
            print("Notifications autorizationStatus: \(settings.authorizationStatus)")
        }
        // Todo(Loucas): Remove this
        print("applicationDidBecomeActive")
        notificationSetting {
            print("notificationSetting: \($0)")
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
                    print("scheduleNotificationSwift: Invalid arguments")
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
    
    private func isNotificationGranted(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
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
        print("scheduleNotificationSwift")
        print("timestamp: \(timestamp), title: \(title), message: \(message)")
    }

    func cancelAllNotifications() {
        // Todo(Loucas): Implement
        print("cancelAllNotificationsSwift")
    }    

    func notificationSetting(completion: @escaping (Bool) -> Void) {
        print("notificationSetting")
        let channel = getMethodChannel();
        channel.invokeMethod(FlutterMethodCall.notificationSetting.rawValue, arguments: nil) { response in
            guard let responseBool = response as? Bool else {
                print("Swift notificationSetting response is not a bool")
                completion(false)
                return
            }
            completion(responseBool)
        }
    }
}
