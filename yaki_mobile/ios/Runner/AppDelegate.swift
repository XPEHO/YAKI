import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var notificationId: String?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        GeneratedPluginRegistrant.register(with: self)
        
        setupNotifications()
        setupMethodChannel()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    /**
     This method is called when the app is about to enter the background.
     It schedules a reminder notification before the app enters the background.
     */
    override func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleReminderNotification()
    }
    
    /**
     This method is called when the app is about to terminate.
     It schedules a reminder notification before the app is terminated.
     */
    override func applicationWillTerminate(_ application: UIApplication) {
        scheduleReminderNotification()
    }
    
    /**
     This method is used to setup notifications for the app.
     
     It sets the UNUserNotificationCenter delegate to self.
     It allows the app to receive notifications when the app is in the foreground.
     */
    func setupNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        // Request authorization
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification access granted")
            } else if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    /**
     This method is used to schedule a reminder notification.
     
     The method generates a unique identifier for the notification request and stores it in the `notificationId` property.
     
     The notification request is then added to the system's notification center.
     If there's an error scheduling the notification, it's printed to the console.s
     */
    func scheduleReminderNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to fill out your YAKI declaration!"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        self.notificationId = uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Schedule the request with the system.
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    /**
     This method is used to setup a method channel for Flutter and native iOS communication.
     
     The method channel is named "com.xpeho.yaki" and is attached to the root FlutterViewController.
     
     It also sets a method call handler that listens for a "disableNotification" call.
     When this call is received, it disables the notification and returns a string "Notification disabled".
     If any other call is received, it returns a FlutterMethodNotImplemented error.
     */
    func setupMethodChannel() {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.xpeho.yaki/notification", binaryMessenger: controller.binaryMessenger)
        
        // Set method call handler
        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "cancelNotifications" {
                self?.disableNotification()
                result("Notification disabled")
            } else if call.method == "scheduleNotifications" {
                self?.scheduleReminderNotification()
                result("Notification enabled")
            }
            
            else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    /**
     This method is used to disable the notification.
     It uses the notificationId to remove the pending notification request.
     */
    func disableNotification() {
        guard let identifier = self.notificationId else { return }
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
