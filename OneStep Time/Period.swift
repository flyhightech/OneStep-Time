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
            return stringFromDate(date1: inDate, date2: Date())
        }
        return "ERROR"
    }
    
    func stringFromDate(date1:Date,date2:Date) -> String {
        
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
    
} //End of the code
