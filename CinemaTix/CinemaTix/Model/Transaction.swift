//
//  Transaction.swift
//  CinemaTix
//
//  Created by Eky on 16/11/23.
//

import Foundation

enum TransType {
    case income, outcome
}

class Transaction {
    let id = UUID()
    var label: String?
    let amount: Double?
    var desc: String?
    var type: TransType?
    
    init(label: String? = nil, amount: Double? = nil, desc: String? = nil, type: TransType? = nil) {
        self.label = label
        self.amount = amount
        self.desc = desc
        self.type = type
    }
}
