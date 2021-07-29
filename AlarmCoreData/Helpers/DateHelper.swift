//
//  DateHelper.swift
//  AlarmCoreData
//
//  Created by lijia xu on 7/29/21.
//

import Foundation

extension Date {
    var dateAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }

}//End Of Date
