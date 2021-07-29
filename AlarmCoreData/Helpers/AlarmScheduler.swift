//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by lijia xu on 7/29/21.
//

import NotificationCenter

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {
        guard let id = alarm.uuidString else { return }
        let content = UNMutableNotificationContent()
        content.title = alarm.title ?? "Alarm"
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate ?? Date())
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { err in
            if let err = err {
                print(err as Any,"#function")
                
            }
        }
        
    }//End Of func
    
    func cancelUserNotifications(for alarm: Alarm) {
        guard let id = alarm.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
}//End Of Extension
