//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by lijia xu on 7/29/21.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    var alarms: [Alarm]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlarms(relaodTable: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAlarms(relaodTable: true)
    }
    
    
    // MARK: - pull data and default to reload table view
    func loadAlarms(relaodTable: Bool) {
        //reduce the calls to the fetch requests, make sure the order same for different fetch results
        alarms = AlarmController.shared.alarms.sorted{ $0.fireDate ?? Date() < $1.fireDate ?? Date() }
        if relaodTable {
            tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmListCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }
        
        let alarmForCell = alarms[indexPath.row]
        
        cell.updateViews(alarm: alarmForCell)
        cell.delegate = self

        return cell
    }

    
    // MARK: - Delete Related:
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedAlarm = alarms[indexPath.row]
            AlarmController.shared.delete(alarm: selectedAlarm)
            loadAlarms(relaodTable: false)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    // MARK: - Navigation

    //toAlarmDetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetailVC" {
            guard let targetVC = segue.destination as? AlarmDetailTableViewController,
                  let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let selectedAlarm = alarms[indexPath.row]
            targetVC.alarm = selectedAlarm
            
        }
    }
    

}//End Of VC

extension AlarmListTableViewController: AlarmTableViewCellDelegate {
    
    func alarmWasToggled(sender: AlarmTableViewCell) {
        guard let selectedIndexPath = tableView.indexPath(for: sender) else { return }
        let selectedAlarm = alarms[selectedIndexPath.row]
        AlarmController.shared.toggleIsEnabledFor(alarm: selectedAlarm)
        sender.updateViews(alarm: selectedAlarm)

    }
}//End Of Extension
