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
    
    func getUserBy(email: String, onSuccess: @escaping ((UserModel) -> Void), onError: ((Error) -> Void)? = nil) {
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let _error = error {
                onError?(_error)
            }
            if let _documents = snapshot?.documents {
                let user = _documents.first
                if let data = user?.data() {
                    let user = UserModel(data[""])
                    onSuccess(user)
                }
                onSuccess()
            }
        }
    }
}
