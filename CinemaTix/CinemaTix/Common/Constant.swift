//
//  Constant.swift
//  CinemaTix
//
//  Created by Eky on 17/11/23.
//

import Foundation

func formatMinutesToHoursAndMinutes(_ totalMinutes: Int) -> String {
    let hours = totalMinutes / 60
    let minutes = totalMinutes % 60
    
    var formattedTime = ""
    
    if hours > 0 {
        formattedTime += "\(hours)h "
    }
    
    if minutes > 0 || hours == 0 {
        formattedTime += "\(minutes)m"
    }
    
    return formattedTime
}

func getDatesForThisWeek() -> [Date] {
    var dates = [Date]()
    let calendar = Calendar.current
    let currentDate = Date.now
    
    for day in 0..<7 {
        if let date = calendar.date(byAdding: .day, value: day, to: currentDate) {
            dates.append(date)
        }
    }
    
    return dates
}
