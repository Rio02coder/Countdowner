//
//  Countdown.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/11/24.
//

import Foundation

//struct Countdown {
//    let id = UUID().uuidString
//    var name: String
//    var description: String?
//}


struct Countdown: Codable, Identifiable {
    let id: String
    var name: String
    var description: String?
    var date: Date
    
    init(name: String, description: String? = nil, date: Date? = nil, id: String = UUID().uuidString) {
        self.id = id
        self.name = name
        self.description = description
        self.date = date ?? Countdown.defaultDate()
    }
    
    static func defaultDate() -> Date {
        // Set the default time to 11:59 PM of the current day
        let calendar = Calendar.current
        let now = Date()
        let components = DateComponents(year: calendar.component(.year, from: now),
                                         month: calendar.component(.month, from: now),
                                         day: calendar.component(.day, from: now),
                                         hour: 23,
                                         minute: 59)
        return calendar.date(from: components) ?? now
    }
}
