//
//  Database.swift
//  CinemaTix
//
//  Created by Eky on 22/11/23.
//

import Foundation
import FirebaseFirestore

class FireDatabase {
    
    let db = Firestore.firestore()
    
    func addUser(user: UserModel, onSuccess: @escaping (() -> Void), onError: ((Error) -> Void)? = nil) {
        let usersCollection = db.collection("users")
        usersCollection.addDocument(data: user.toDict()) { error in
            if let _error = error {
                onError?(_error)
            } else {
                onSuccess()
            }
        }
    }
    
    func getUserBy(email: String, onSuccess: @escaping ((UserModel) -> Void), onError: ((Error) -> Void)? = nil) {
        let usersCollection = db.collection("users")
        usersCollection.whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let _error = error {
                onError?(_error)
            }
            if let _documents = snapshot?.documents {
                let user = _documents.first
                if let data = user?.data() {
                    let user = UserModel.fromDict(data)
                    onSuccess(user)
                } else {
                    onError?(NSError())
                }
            } else {
                onError?(NSError())
            }
        }
    }
    
    func getWalletBy(id: String, onSuccess: @escaping ((WalletModel) -> Void), onError: ((Error) -> Void)? = nil) {
        let walletsCollection = db.collection("wallets")
        walletsCollection.document(id).getDocument { document, error in
            if let _error = error {
                onError?(_error)
            }
            if let _document = document, _document.exists {
                if let data = _document.data() {
                    let wallet = WalletModel.fromDict(data)
                    onSuccess(wallet)
                } else {
                    onError?(NSError())
                }
            } else {
                onError?(NSError())
            }
        }
    }
}
