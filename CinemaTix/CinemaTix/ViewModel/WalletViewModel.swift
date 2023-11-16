//
//  WalletViewModel.swift
//  CinemaTix
//
//  Created by Eky on 16/11/23.
//

import Foundation

class WalletViewModel: BaseViewModel {
    
    private var transactions: [Transaction] = []
    
    func getTrans(_ index: Int) -> Transaction{
        return transactions[index]
    }
    
    func addTrans(amount: Double) {
        transactions.append(Transaction(amount: amount))
    }
    
    func deleteTrans(index: Int) {
        transactions.remove(at: index)
    }
    
    func editTrans(_ index: Int, label: String?, type: TransType?, desc: String?) {
        transactions[index].label = label
        transactions[index].type = type
        transactions[index].desc = desc
    }
}
