import UserNotifications

extension AppDelegate {
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
    func createNotification() -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = notificationSettings.messageTitle
        content.body = notificationSettings.messageBody
        
        var dateComponents = DateComponents()
        dateComponents.hour = notificationSettings.hours
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
        let uuidString = UUID().uuidString
        AppDelegate.shared.notificationId = uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        return request
    }
    
    /**
     This method is used to schedule a reminder notification.
     
     The method generates a unique identifier for the notification request and stores it in the `notificationId` property.
     
     The notification request is then added to the system's notification center.
     If there's an error scheduling the notification, it's printed to the console.s
     */
    func scheduleNotification() {
        // Check if current day is a weekend
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: Date())
        if dayOfWeek == 1 || dayOfWeek == 7 { // 1 for Sunday, 7 for Saturday
            debugPrint("It's a weekend, no notification scheduled")
            return
        }
        
        let request = createNotification()
        let notificationCenter = UNUserNotificationCenter.current()
        
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
    
    /**
     This method is used to disable the notification.
     It uses the notificationId to remove the pending notification request.
     */
    func disableNotification() {
        guard let identifier = AppDelegate.shared.notificationId else { return }
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        AppDelegate.shared.isNotificationScheduled = false
        debugPrint("Notification disabled")
    }
}
