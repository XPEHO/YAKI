import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    /**
     This method is used to get the shared instance of the AppDelegate.
     */
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
    
    /**
     This method is called when the app is about to enter the foreground.
     It checks if the app has notification authorization.
     If the app doesn't have authorization, it disables the notification.
     */
    override func applicationDidBecomeActive(_ application: UIApplication) {
        getDeclaredDays {
            debugPrint("Declared days: \($0)")
            // Note(Loucas): Handle notification scheduling using the declared days here
        }
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                self.disableNotification();
            }
        }
    }
    
    /**
     This method is called to schedule a reminder notification.
     */
    func scheduleNotificationIfAuthorized() {
        let isAuthorized = AppDelegate.shared.isScheduleNotificationAuthorized
        let isScheduled = AppDelegate.shared.isNotificationScheduled
        
        if (!isAuthorized || isScheduled) {
            debugPrint("notification not authorized or already scheldule");
            return
        }
        scheduleNotification()
    }
    
    
    /**
     This method is called when the app is about to enter the background.
     It schedules a reminder notification  before the app enters the background.
     */
    override func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleNotificationIfAuthorized()
    }
    
    /**
     This method is called when the app is about to terminate.
     It schedules a reminder notification before the app is terminated.
     */
    override func applicationWillTerminate(_ application: UIApplication) {
        scheduleNotificationIfAuthorized()
    }
}
