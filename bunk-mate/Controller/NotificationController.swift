//
//  NotificationController.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 16/10/23.
//

import SwiftUI
import UserNotifications


class NotificationController {
    
    @AppStorage("allowNotifications") var allowNotifications : Bool = false
    static let shared = NotificationController()
    
    func requestPermission(){
        let options : UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options:options) { success, error in
            if let error = error {
                print("Error")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification(hour:Int, minute:Int){
        
        let sound : UNNotificationSound = UNNotificationSound.defaultCritical
        
        if let soundURL = Bundle.main.url(forResource: "bunkmate-notification", withExtension: "mp3"){
            let sound = UNNotificationSound(named: UNNotificationSoundName(soundURL.absoluteString))
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Attendance Reminder"
        content.body = "Remember to mark your attendance for the day"
        content.sound = sound
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
