//
//  CountdownUtils.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/23/24.
//

import Foundation
import FirebaseFirestore

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


func getTimeIntervalNumberFromCurrentDateAsStr(date: Date) -> String {
        let timeInterval = calendar.dateComponents([.year, .month, .day], from: .now, to: date)
        if let years = timeInterval.year, years > 0 {
            return "\(years) Yr\(years > 1 ? "s" : "")"
        }
        if let months = timeInterval.month, months > 0 {
            return "\(months) Mo\(months > 1 ? "s" : "")"
        }
        if let days = timeInterval.day, days > 0 {
            return "\(days) Dy\(days > 1 ? "s" : "")"
        }
        return ""
    }
