//
//  ExtDate.swift
//  CinemaTix
//
//  Created by Eky on 23/11/23.
//

import Foundation

extension Date {
    static func from(day: Int, month: Int, year: Int) -> Date? {
        // Create a calendar
        let calendar = Calendar.current
        
        // Set the date components
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        // Create the date using the calendar and date components
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            // Invalid date components
            return nil
        }
    }
}
