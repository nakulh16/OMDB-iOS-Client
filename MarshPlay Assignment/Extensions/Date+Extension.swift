//
//  Date+Extension.swift
//  MarshPlay Assignment
//
//  Created by Nakul Hindustani on 23/03/19.
//  Copyright © 2019 Nakul Hindustani. All rights reserved.
//

import Foundation

extension Date {
    func getElapsedInterval() -> String {
        if let interval = Calendar.current.dateComponents([.year], from: self, to: Date()).year, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "year ago" :
                "\(interval)" + " " + "years ago"
        }
        
        return "a moment ago"
    }
}
