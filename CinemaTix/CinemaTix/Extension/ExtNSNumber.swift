//
//  ExtNSNumber.swift
//  CinemaTix
//
//  Created by Eky on 17/11/23.
//

import Foundation

extension NSNumber {
    func formatAsDecimalString() -> String {
        let numberFormatter = currencyFormatter
        if let formattedString = numberFormatter.string(from: self) {
            return formattedString
        } else {
            return "\(self)"
        }
    }
}
