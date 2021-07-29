//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by lijia xu on 7/29/21.
//

import CoreData

class AlarmController: AlarmScheduler {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] {
        let fetchAllAlarmsRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchAllAlarmsRequest)
        } catch {
            print(error)
            return []
        }
        
    }
    
    // MARK: - CRUD functions
    
    func createAlarm(withTitle title: String, isEnabled: Bool, fireDate: Date) {
        let alarm = Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
        scheduleUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        cancelUserNotifications(for: alarm)
        scheduleUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        
        cancelUserNotifications(for: alarm)
        
        switch alarm.isEnabled {
        case true:
            scheduleUserNotifications(for: alarm)
        case false:
            break
        }
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm) {
        CoreDataStack.context.delete(alarm)
        cancelUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        CoreDataStack.saveContext()
    }
    
    
    // MARK: - private init
    private init(){}
    
}//End Of class
