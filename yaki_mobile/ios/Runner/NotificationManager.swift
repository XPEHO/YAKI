import UserNotifications

extension AppDelegate {
    /**
     This method check if the permission is granted for the app to send notifications.
     */
    func checkPermission(result: @escaping FlutterResult) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let isAuthorized = settings.authorizationStatus == .authorized
            return result(isAuthorized)
        }
    }
    
    /**
     This method is used to setup notifications for the app.
     
     It sets the UNUserNotificationCenter delegate to self.
     Allows the app to receive notifications when the app is in the foreground.
     
     Requests authorization setting "isScheduleNotificationTriggered" to true, allowing notifications to be set.
     */
    func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        debugPrint("asking for permissions")
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        // Request authorization
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                debugPrint("Notification access granted")
                completion(true)
            } else if let error = error {
                debugPrint("Error: \(error)")
                completion(false)
            }
        }
        getNotificationParameters();
    }
    
    /**
     Creates and returns a `UNNotificationRequest` for a reminder notification.
     
     This function creates a `UNNotificationRequest` with a title and a body.
     The notification is set to trigger every day at 9 AM.
     
     - Returns: A `UNNotificationRequest` that represents the reminder notification.
     
     - Note: The `UNNotificationRequest`'s identifier is a newly generated UUID string, which is also stored in `AppDelegate.shared.notificationId`.s
     */
    func createNotification() -> [UNNotificationRequest] {
        var requests = [UNNotificationRequest]()
        AppDelegate.shared.notificationIds = [String]()
        let content = UNMutableNotificationContent()
        content.title = notificationSettings.messageTitle
        content.body = notificationSettings.messageBody
        
        for weekday in 2...6 { // 2 for Monday, 6 for Friday
            var dateComponents = DateComponents()
            dateComponents.hour = notificationSettings.hours
            dateComponents.weekday = weekday
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let uuidString = UUID().uuidString
            AppDelegate.shared.notificationIds?.append(uuidString)
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            requests.append(request)
        }
        return requests
    }
    
    /**
     This method is used to schedule a reminder notification.
     
     The method generates a unique identifier for the notification request and stores it in the `notificationId` property.
     
     The notification request is then added to the system's notification center.
     If there's an error scheduling the notification, it's printed to the console.s
     */
    func scheduleNotification() {
        let requests = createNotification()
        let notificationCenter = UNUserNotificationCenter.current()
        
        
        for request in requests {
            // Schedule the request with the system.
            notificationCenter.add(request) { (error) in
                if let error = error {
                    debugPrint("Error: \(error)")
                } else {
                    debugPrint("Notification scheduled successfully")
                    AppDelegate.shared.isNotificationScheduled = true
                }
            }
        }
    }
    
    /**
     This method is used to disable the notification.
     It uses the notificationId to remove the pending notification request.
     */
    func disableNotification() {
        guard let identifiers = AppDelegate.shared.notificationIds else { return }
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
        AppDelegate.shared.isNotificationScheduled = false
        debugPrint("Notification disabled")
    }
}
