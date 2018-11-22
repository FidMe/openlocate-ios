//
//  PushNotificationManager.swift
//  Howdy
//
//  Created by Loic SENCE on 30/07/2018.
//  Copyright © 2018 Howdy. All rights reserved.
//

import UIKit
import UserNotifications

@available(iOS 10.0, *)
@objc public class PushNotificationManager: NSObject {
    
    @objc public static func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
        }
    }
    
    @objc public static func notify(text: String) {
        let content = UNMutableNotificationContent()
        content.body = text
        content.title = "Location posted"
        content.sound = nil
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
