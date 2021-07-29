//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by lijia xu on 7/29/21.
//

import UIKit

protocol AlarmTableViewCellDelegate: AnyObject {
    func alarmWasToggled(sender: AlarmTableViewCell)
}


class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnableSwitchOutlet: UISwitch!
    
    weak var delegate: AlarmTableViewCellDelegate?
    
    func updateViews(alarm: Alarm) {
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate?.dateAsString
        isEnableSwitchOutlet.isOn = alarm.isEnabled
    }
    
    
    @IBAction func isEnabledSwitchToggled(_ sender: UISwitch) {
        delegate?.alarmWasToggled(sender: self)
    }
    
}
