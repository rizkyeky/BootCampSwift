//
//  WalletViewModel.swift
//  CinemaTix
//
//  Created by Eky on 16/11/23.
//

import Foundation

class WalletViewModel: BaseViewModel {
    
    private var transactions: [Transaction] = []
    
    func getLenTrans() -> Int {
        return transactions.count
    }
    
    func getTotalAmount() -> Double {
        var temp = 0.0
        transactions.forEach { item in
            temp += item.amount ?? 0
        }
        return temp
    }
    
    func getTrans(_ index: Int) -> Transaction {
        return transactions[index]
    }
    
    func addTrans(label: String, amount: Double, type: TransType) {
        let num = transactions.count + 1
        transactions.append(Transaction(label: label+String(num), amount: amount, type: type))
    }
    
    func deleteTransBy(index: Int) {
        transactions.remove(at: index)
    }
    
    func deleteTransBy(id: UUID) {
        if let index = transactions.firstIndex(where: { item in
            return item.id == id
        }) {
            transactions.remove(at: index)
        }
        
    }
    
    func editTrans(_ index: Int, label: String?, type: TransType?, desc: String?) {
        if let _label = label {
            transactions[index].label = _label
        }
        if let _type = type {
            transactions[index].type = _type
        }
        if let _desc = desc {
            transactions[index].desc = _desc
        }
    }
}
