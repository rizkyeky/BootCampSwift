//
//  Constant.swift
//  CinemaTix
//
//  Created by Eky on 17/11/23.
//

import Foundation

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 3
    return formatter
}()

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd, MMMM yyyy"
    return formatter
}()

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
