//
//  WalletViewModel.swift
//  CinemaTix
//
//  Created by Eky on 16/11/23.
//

import Foundation

class WalletViewModel: BaseViewModel {
    
    private var transactions: [Transaction] = []
    
    let authViewModel = ContainerDI.shared.resolve(AuthViewModel.self)!
    
    let fireDb = FireDatabase()
    
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
    
    func addTrans(label: String, amount: Double, type: TransType, onSuccess: @escaping (() -> Void), onError: ((ErrorService) -> Void)? = nil) {
        let num = transactions.count + 1
        var trans = Transaction(label: label+String(num), amount: amount, type: type.rawValue)
        fireDb.addTransaction(trans: trans) { id in
            trans.id = id
            self.transactions.append(trans)
            if let _id = id {
                self.authViewModel.activeUser?.wallet?.transactions?.append(_id)
                if let wallet = self.authViewModel.activeUser?.wallet {
                    self.fireDb.updateWallet(wallet: wallet) {
                        onSuccess()
                    } onError: { error in
                        onError?(error)
                    }
                } else {
                    onError?(ErrorService(message: "User wallet is not found"))
                }
            } else {
                onError?(ErrorService(message: "Trans ID is not found"))
            }
        } onError: { error in
            onError?(error)
        }
    }
    
    func deleteTransBy(index: Int) {
        transactions.remove(at: index)
    }
    
    func deleteTransBy(id: String) {
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
    
    func getWalletFB(onSuccess: @escaping (() -> Void), onError: ((ErrorService) -> Void)?) {
        if let user = authViewModel.activeUser {
            if let wallet = user.wallet {
                if let id = wallet.id {
                    fireDb.getWalletBy(id: id) { wallet in
                        self.authViewModel.activeUser?.wallet = wallet
                        self.fireDb.getTransactionsBy(wallet: wallet) { transactions in
                            self.transactions = transactions
                            onSuccess()
                        } onError: { error in
                            onError?(error)
                        }
                    } onError: { error in
                        onError?(error)
                    }
                } else {
                    onError?(ErrorService(message: "Wallet ID is not found"))
                }
            } else {
                onError?(ErrorService(message: "Wallet is not found"))
            }
        } else {
            onError?(ErrorService(message: "Active user is not found"))
        }
    }
}
