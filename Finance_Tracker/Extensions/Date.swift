//
//  Date.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/29.
//

import Foundation

extension Date {
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    private var getWeekday: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = .init(identifier: "zh_Hunt_TW")
        return formatter
    }
    
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
    
    func shortWeekdayString() -> String {
        return getWeekday.string(from: self)
    }
}
