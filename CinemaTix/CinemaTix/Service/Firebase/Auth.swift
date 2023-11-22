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
    
    func signIn(email: String, password: String, onSuccess: @escaping ((FirebaseAuth.User) -> Void), onError: ((Error) -> Void)? = nil) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let _error = error {
                onError?(_error)
            }
            if let _result = result {
                onSuccess(_result.user)
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
                    onSuccess(_result.user)
                }
            }
        }
    }
}
