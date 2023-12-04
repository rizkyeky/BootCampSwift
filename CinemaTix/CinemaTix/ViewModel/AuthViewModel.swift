//
//  AuthViewModel.swift
//  CinemaTix
//
//  Created by Eky on 10/11/23.
//

import Foundation
import RxSwift
import CoreData
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: BaseViewModel {
    
    var email: String?
    var password: String?
    var username: String?
    var birthDateTemp: Date = Date()
    
    let biometric = ContainerDI.shared.resolve(BiometricAuth.self)
    
    let fireAuth = FireAuth()
    
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
    
//    func signIn(onSuccess: @escaping ((UserModel) -> Void), onDone: (() -> Void)? = nil, onInvalidEmail: (() -> Void)? = nil, onInvalidPassword: (() -> Void)? = nil) {
//        
//        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
//            if let correctPass = password, !correctPass.isEmpty {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//                    let context = appDelegate.persistentContainer.viewContext
//                    if let user = self.dataController?.getUser(email: correctEmail, password: correctPass, context: context) {
//                        let userModel = UserModel(
//                            email: user.email ?? correctEmail,
//                            displayName: user.displayName,
//                            birthDate: user.birthDate,
//                            username: user.username,
//                            gender: Int(user.gender)
//                        )
//                        ContainerDI.shared.register(UserModel.self) { r in
//                            return userModel
//                        }.inObjectScope(.container)
//                        
//                        onSuccess(userModel)
//                        onDone?()
//                    } else {
//                        onInvalidEmail?()
//                        onDone?()
//                    }
//                }
//            } else {
//                print("Invalid Password")
//                onInvalidPassword?()
//                onDone?()
//            }
//        } else {
//            print("Invalid Email")
//            onInvalidEmail?()
//            onDone?()
//        }
//         
//        email = nil
//        password = nil
//    }
    
//    func register(onSuccess: @escaping ((UserModel) -> Void), onDone: (() -> Void)? = nil, onInvalidEmail: (() -> Void)? = nil, onInvalidUsername: (() -> Void)? = nil, onInvalidPassword: (() -> Void)? = nil) {
//         
//        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
//            if let correctPass = password, !correctPass.isEmpty {
//                if let correctUsername = username, !correctPass.isEmpty {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//                        let context = appDelegate.persistentContainer.viewContext
//                        if let user = self.dataController?.addUser(username: correctUsername, email: correctEmail, password: correctPass, context: context) {
//                            
//                            let userModel = UserModel(
//                                email: user.email ?? correctEmail,
//                                displayName: user.displayName,
//                                birthDate: user.birthDate,
//                                username: user.username,
//                                gender: Int(user.gender)
//                            )
//                            ContainerDI.shared.register(UserModel.self) { r in
//                                return userModel
//                            }.inObjectScope(.container)
//                            
//                            onSuccess(userModel)
//                            onDone?()
//                        }
//                    }
//                } else {
//                    print("Invalid Username")
//                    onInvalidUsername?()
//                    onDone?()
//                }
//            } else {
//                print("Invalid Password")
//                onInvalidPassword?()
//                onDone?()
//            }
//        } else {
//            print("Invalid Email")
//            onInvalidEmail?()
//            onDone?()
//        }
//        
//        email = nil
//        password = nil
//        username = nil
//        
//    }
}
