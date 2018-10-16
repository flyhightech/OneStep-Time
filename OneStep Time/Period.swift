//
//  Period.swift
//  OneStep Time
//
//  Created by Bernard Huff on 10/14/18.
//  Copyright © 2018 Flyhightech.LLC. All rights reserved.
//

import Cocoa

extension Period {
    
    func currentlyString() -> String {
        if let inDate = self.inDate {
            return Period.stringFromDate(date1: inDate, date2: Date())
        }
        return "ERROR"
    }
    
    class func stringFromDate(date1:Date,date2:Date) -> String {
        
        var theString = ""
        
        let cal = Calendar.current.dateComponents([.hour, .minute, .second], from: date1, to: date2)
        
        guard let hour = cal.hour, let minute = cal.minute, let second = cal.second else {
            return "ERROR"
        }
        if hour > 0 {
            theString += "\(hour)h \(minute)m "
        } else {
            if minute > 0 {
                theString += "\(minute)m "
            }
        }
        
        theString += "\(second)s "
        
        return theString
    }
    
    func prettyDate(date:Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        return formatter.string(from:date)
        
    }
    
    func prettyInDate() -> String {
        
        if let inDate = self.inDate {
            return prettyDate(date: inDate)
        }
        
        return "Error"
        
    }
    
    func prettyOutDate() -> String {
        
        if let outDate = self.outDate {
            return prettyDate(date: outDate)
        }
        
        return "Error"
        
    }
    
    func time() -> TimeInterval {
        if let inDate = self.inDate {
            if let outDate = self.outDate {
               return outDate.timeIntervalSince(inDate)
            } else {
                return Date().timeIntervalSince(inDate)
            }
        }
        return 0.0
    }
    
} //End of the code
