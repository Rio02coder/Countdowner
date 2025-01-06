//
//  CountdownUtils.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 1/5/25.
//

import Foundation

let calendar = Calendar.current

func getTimeIntervalNumberFromCurrentDate(date: Date) -> Int {
    let timeInterval = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now, to: date)
    if (timeInterval.year != nil && timeInterval.year! > 0) {
        return timeInterval.year!
    }
    
    if(timeInterval.month != nil && timeInterval.month! > 0) {
        return timeInterval.month!
    }
    
    if(timeInterval.day != nil && timeInterval.day! > 0) {
        return timeInterval.day!
    }
    
    if(timeInterval.hour != nil && timeInterval.hour! > 0) {
        return timeInterval.hour!
    }
    
    if(timeInterval.minute != nil && timeInterval.minute! > 0) {
        return timeInterval.minute!
    }
    
    return 0
}
