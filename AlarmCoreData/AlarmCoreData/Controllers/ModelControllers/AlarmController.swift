//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by lijia xu on 7/29/21.
//

import CoreData

//protocol PropertyRetriveable {
//    associatedtype PropertiesEnum
//    func propertyType(_ propertyEnum: PropertiesEnum)
//}




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
    
    // MARK: - Fetch Alarms (Generic)

//    func fetchData<T: PropertyRetriveable>(_ type: T, sortedby enum: T.PropertiesEnum) -> [T] {
//
//    }
    
    // MARK: - CRUD functions
    
    func createAlarm(withTitle title: String, isEnabled: Bool, fireDate: Date) {
        let alarm = Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
       
        changeNotification(for: alarm, shouldOn: isEnabled)
        
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        
        changeNotification(for: alarm, shouldOn: alarm.isEnabled)

        saveToPersistentStore()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        
        changeNotification(for: alarm, shouldOn: alarm.isEnabled)
        
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm) {
        CoreDataStack.context.delete(alarm)
        
        changeNotification(for: alarm, shouldOn: false)
        
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        CoreDataStack.saveContext()
    }
    
    // MARK: - Notification status helper

    private func changeNotification(for alarm: Alarm, shouldOn: Bool) {
        
        cancelUserNotifications(for: alarm)
        
        switch shouldOn {
        case true:
            scheduleUserNotifications(for: alarm)
        case false:
            break
        }
    }
    
    
    // MARK: - private init
    private init(){}
    
}//End Of class
