//
//  AuthViewModel.swift
//  CinemaTix
//
//  Created by Eky on 18/12/23.
//

import Foundation

class AuthViewModel: BaseViewModel {
    
    var email: String?
    var password: String?
    var username: String?
    var birthDateTemp: Date = Date()
    
    let biometric = BiometricAuth()
    
    private let fireAuth = FireAuth()
    
    var activeUser: UserModel?
    
    func checkActiveUser(onSuccess: @escaping ((UserModel?) -> Void), onError: ((Error) -> Void)? = nil) {
        fireAuth.getCurrUser { user in
            if let _user = user {
                self.activeUser = _user
                onSuccess(self.activeUser)
            } else {
                onSuccess(nil)
            }
        } onError: { error in
            onError?(error)
        }
    }
    
    func signInWithFB(onSuccess: @escaping (() -> Void), onError: ((Error) -> Void)? = nil, onInvalidEmail: (() -> Void)? = nil, onInvalidPassword: (() -> Void)? = nil) {
        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
            if let correctPass = password, !correctPass.isEmpty {
                fireAuth.signIn(email: correctEmail, password: correctPass) { user in
                    self.activeUser = user
                    onSuccess()
                    self.email = nil
                    self.password = nil
                } onError: { error in
                    onError?(error)
                }
            } else {
                onInvalidPassword?()
            }
        } else {
            onInvalidEmail?()
        }
    }
    
    func registerWithFB(onSuccess: @escaping (() -> Void), onError: ((Error) -> Void)? = nil, onInvalidEmail: (() -> Void)? = nil, onInvalidPassword: (() -> Void)? = nil) {
        
        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
            if let correctPass = password, !correctPass.isEmpty {
                let _user = UserModel(email: correctEmail)
                fireAuth.register(user: _user, password: correctPass) { auth, id in
                    if auth.email == correctEmail {
                        self.activeUser = _user
                        self.activeUser?.id = id
                        self.activeUser?.username = self.username
                        self.activeUser?.displayName = auth.displayName
                        self.activeUser?.birthDate = self.birthDateTemp
                        onSuccess()
                        self.email = nil
                        self.password = nil
                        self.username = nil
                    }
                } onError: { error in
                    onError?(error)
                }
            } else {
                onInvalidPassword?()
            }
        } else {
            onInvalidEmail?()
        }
    }
    
    func signOut(onSuccess: @escaping (() -> Void), onError: ((Error) -> Void)? = nil) {
        fireAuth.signOut {
            onSuccess()
            self.activeUser = nil
        } onError: { error in
            onError?(error)
            self.activeUser = nil
        }
    }
}
