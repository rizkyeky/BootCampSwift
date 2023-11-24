//
//  Transaction.swift
//  CinemaTix
//
//  Created by Eky on 16/11/23.
//

import Foundation

enum TransType: Int {
    case income, outcome
    
    static func from(_ ind: Int?) -> TransType? {
        if let index = ind {
            return TransType.init(rawValue: index)
        } else {
            return nil
        }
    }
}

struct Transaction {
    let id = UUID()
    var label: String?
    let amount: Double?
    var desc: String?
    var type: TransType?
    
    init(label: String, amount: Double? = nil, desc: String? = nil, type: Int? = nil) {
        self.label = label
        self.amount = amount
        self.desc = desc
        self.type = TransType.from(type)
    }
}
