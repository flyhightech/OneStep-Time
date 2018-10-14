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
        
        return theString
    }
    
} //End of the code
