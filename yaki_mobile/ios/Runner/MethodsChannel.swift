import Flutter

extension AppDelegate {
    /**
     This method is used to get the FlutterMethodChannel instance.
     It first gets the root FlutterViewController from the window,
     then creates and returns a FlutterMethodChannel with the specified channel name and the binaryMessenger of the controller.
     */
    func getMethodChannel() -> FlutterMethodChannel {
        let controller: FlutterViewController? = window?.rootViewController as? FlutterViewController
        return FlutterMethodChannel(name: FlutterChannel.name.rawValue, binaryMessenger: controller!.binaryMessenger)
    }
    
   /**
    Get the list of days that have been declared by the user.
    */
    func getDeclaredDays(completion: @escaping ([String]) -> Void) {
        let channel = getMethodChannel();
        
        channel.invokeMethod(FlutterChannel.getDeclaredDays.rawValue, arguments: nil) { (result: Any?) in
            if let result = result as? [String] {
                completion(result)
            }
        }
    }
    
    /**
     This method is used to retrive the notification parameters values from flutter.
     This using the flutter channels.
     */
    func getNotificationParameters() {
        let channel = getMethodChannel();
        
        channel.invokeMethod(FlutterChannel.getNotificationParams.rawValue, arguments: nil) { (result: Any?) in
            if let result = result as? [String: Any] {
                notificationSettings.messageTitle = result[NotificationParams.title.rawValue] as? String ?? notificationSettings.messageTitle
                notificationSettings.messageBody = result[NotificationParams.message.rawValue] as? String ?? notificationSettings.messageBody
                notificationSettings.hours = result[NotificationParams.hour.rawValue] as? Int ?? notificationSettings.hours
                notificationSettings.minutes = result[NotificationParams.minute.rawValue] as? Int ?? notificationSettings.minutes
                
                debugPrint("Notification parameters: \(notificationSettings)")
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
        let channel = getMethodChannel();
        
        // Set method call handler
        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == FlutterChannel.cancelNotifications.rawValue {
                self?.disableNotification()
                AppDelegate.shared.isScheduleNotificationAuthorized = false
                result("Notification disabled")
            } else if call.method == FlutterChannel.scheduleNotifications.rawValue {
                self?.handleScheduleNotifications(result: result)
            } else if call.method == FlutterChannel.areNotificationsPermitted.rawValue {
                self?.checkPermission(result: result)
            }
            else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    /**
     This method is used to handle the scheduleNotifications method call from Flutter.
     
     It checks if the app has notification authorization.
     If the app has authorization, it sets "(UIApplication.shared.delegate as? AppDelegate).isScheduleNotificationAuthorized" to true.
     If the app doesn't have authorization, it requests authorization and sets "(UIApplication.shared.delegate as? AppDelegate).isScheduleNotificationAuthorized" to true if granted.
     */
    func handleScheduleNotifications(result: @escaping FlutterResult) {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    strongSelf.isScheduleNotificationAuthorized = true
                    result("Notification enabled")
                } else {
                    debugPrint("Notification not enabled")
                    self?.requestNotificationAuthorization{ granted in
                        if granted {
                            strongSelf.isScheduleNotificationAuthorized = true
                            debugPrint("Notification enabled from return")                 
                        } else {
                            strongSelf.isScheduleNotificationAuthorized = false 
                        }
                    } 
                }
            }
        }
    }
}
