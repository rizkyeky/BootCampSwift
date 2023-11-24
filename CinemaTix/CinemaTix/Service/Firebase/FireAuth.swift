//
//  Auth.swift
//  CinemaTix
//
//  Created by Eky on 22/11/23.
//

import Foundation
import FirebaseAuth

class FireAuth {
    
    private let auth = Auth.auth()
    private let database = FireDatabase()
    
    func getCurrUser(onSuccess: @escaping ((UserModel?) -> Void), onError: ((Error) -> Void)? = nil) {
        if let user = auth.currentUser {
            if let userEmail = user.email {
                self.database.getUserBy(email: userEmail) { user in
                    onSuccess(user)
                } onError: { error in
                    onError?(error)
                }
            } else {
                onSuccess(nil)
            }
        } else {
            onSuccess(nil)
        }
    }
    
    func signIn(email: String, password: String, onSuccess: @escaping ((UserModel) -> Void), onError: ((Error) -> Void)? = nil) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let _error = error {
                onError?(_error)
            }
            if let fireUser = result?.user {
                if let userEmail = fireUser.email {
                    self.database.getUserBy(email: userEmail) { user in
                        onSuccess(user)
                    } onError: { error in
                        onError?(error)
                    }
                }
            }
        }
    }
    
    func register(user: UserModel, password: String, onSuccess: @escaping ((FirebaseAuth.User) -> Void), onError: ((Error) -> Void)? = nil) {
        if let email = user.email {
            auth.createUser(withEmail: email, password: password) { result, error in
                if let _error = error {
                    onError?(_error)
                }
                if let _result = result {
                    self.database.addUser(user: user) {
                        onSuccess(_result.user)
                    } onError: { error in
                        onError?(error)
                    }
                } else {
                    onError?(NSError())
                }
            }
        }
    }
    
    func signOut(onSuccess: @escaping (() -> Void), onError: ((Error) -> Void)? = nil) {
        do {
            try auth.signOut()
            onSuccess()
        } catch let signOutError as NSError {
            onError?(signOutError)
        }
    }
}
