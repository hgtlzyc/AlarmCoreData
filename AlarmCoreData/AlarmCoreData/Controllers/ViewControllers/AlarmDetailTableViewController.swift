//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by lijia xu on 7/29/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    
    
    var isAlarmOn: Bool = true
    var alarm: Alarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        defer {
            designIsEnabledButton()
        }
        
        guard let alarm = alarm else { return }
        alarmFireDatePicker.date = alarm.fireDate ?? Date()
        alarmTitleTextField.text = alarm.title
        isAlarmOn = alarm.isEnabled
        
    }
    
    func designIsEnabledButton() {
        switch isAlarmOn {
        case true:
            alarmIsEnabledButton.backgroundColor = .white
            alarmIsEnabledButton.setTitle("Enabled", for: .normal)
        case false:
            alarmIsEnabledButton.backgroundColor = .darkGray
            alarmIsEnabledButton.setTitle("Disabled", for: .normal)
        }
    }
    
    
    
    @IBAction func savebuttonTapped(_ sender: Any) {
        guard let titleText = alarmTitleTextField.text, !titleText.isEmpty else { return }
        
        switch alarm {
        case let alarm?:
            AlarmController.shared.update(alarm: alarm, newTitle: titleText,
                                          newFireDate: alarmFireDatePicker.date,
                                          isEnabled: isAlarmOn)
            
        case nil:
            AlarmController.shared.createAlarm(withTitle: titleText,
                                               isEnabled: isAlarmOn,
                                               fireDate: alarmFireDatePicker.date)
            
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        switch alarm {
        case let alarm?:
            AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
            isAlarmOn = alarm.isEnabled
            
        case nil:
            isAlarmOn.toggle()
        }
        
        designIsEnabledButton()
    }
    
}
