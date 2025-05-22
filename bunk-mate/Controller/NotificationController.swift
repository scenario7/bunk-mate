//
//  NotificationController.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 16/10/23.
//

import SwiftUI
import UserNotifications


class NotificationController {
    
    @FetchRequest(entity: Lecture.entity(), sortDescriptors: []) var lectures : FetchedResults<Lecture>
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
    
    func scheduleNotification(){
        
        let sound : UNNotificationSound = UNNotificationSound.defaultCritical
        
        if let soundURL = Bundle.main.url(forResource: "bunkmate-notification", withExtension: "mp3"){
            let sound = UNNotificationSound(named: UNNotificationSoundName(soundURL.absoluteString))
        }
        
        for lecture in lectures {
            
            let calendar = Calendar.current
            let currentDate = Date()
            let notificationTime = lecture.startTime!.addingTimeInterval(-30 * 60)
            let components = calendar.dateComponents([.hour, .minute], from: notificationTime)
            
            let content = UNMutableNotificationContent()
            content.title = "\(lecture.toSubject!.name!) class at \(components.hour):\(components.minute)"
            content.body = "Lecture begins in 30 minutes"
            content.sound = sound
            
            var dateComponents = DateComponents()
            dateComponents.hour = components.hour
            dateComponents.minute = components.minute
            dateComponents.day = (Int(lecture.day) + 6) % 7
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            UNUserNotificationCenter.current().add(request)
        }
        
    }
    
}
