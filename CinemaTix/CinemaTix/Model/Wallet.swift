//
//  Wallet.swift
//  CinemaTix
//
//  Created by Eky on 24/11/23.
//

import Foundation

struct WalletModel {
    
    let id: UUID?
    var label: String?
    var desc: String?
    var amount: Double?
    var transactions: [String]?
    
    init(id: UUID? = nil, label: String? = nil, desc: String? = nil, amount: Double? = nil, transactions: [String]? = nil) {
        self.id = id
        self.label = label
        self.desc = desc
        self.amount = amount
        self.transactions = transactions
    }
    
    static func fromDict(_ dict: [String: Any?]) -> WalletModel {
        return WalletModel(
            label: (dict["label"] as? String),
            desc: dict["desc"] as? String,
            amount: dict["amount"] as? Double,
            transactions: dict["transactions"] as? [String]
        )
    }

}
