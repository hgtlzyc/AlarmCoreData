//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by lijia xu on 7/29/21.
//

import CoreData

class AlarmController {
    
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
    
    func createAlarm(withTitle title: String, and fireDate: Date) {
        Alarm(title: title, isEnabled: true, fireDate: fireDate)
        
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        
        saveToPersistentStore()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()

        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm) {
        CoreDataStack.context.delete(alarm)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        CoreDataStack.saveContext()
    }
    
    
    // MARK: - private init
    private init(){}
    
}//End Of class
