//
//  ExtInt.swift
//  CinemaTix
//
//  Created by Eky on 30/11/23.
//

import Foundation

extension Int {
    func formatMinutesToHoursAndMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        var formattedTime = ""
        
        if hours > 0 {
            formattedTime += "\(hours)h "
        }
        
        if minutes > 0 || hours == 0 {
            formattedTime += "\(minutes)m"
        }
        
        return formattedTime
    }
}
