//
//  AuthViewModel.swift
//  CinemaTix
//
//  Created by Eky on 10/11/23.
//

import Foundation
import RxSwift
import CoreData

class AuthViewModel: BaseViewModel {
    
    var email: String?
    var password: String?
    var username: String?
    
    let biometric = ContainerDI.shared.resolve(BiometricAuth.self)
    
    let dataController = ContainerDI.shared.resolve(DataController.self)
    
    func signIn(onSuccess: @escaping ((UserModel) -> Void), onDone: (() -> Void)? = nil, onInvalidEmail: (() -> Void)? = nil, onInvalidPassword: (() -> Void)? = nil) {
        
        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
            if let correctPass = password, !correctPass.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let context = appDelegate.persistentContainer.viewContext
                    if let user = self.dataController?.getUser(email: correctEmail, password: correctPass, context: context) {
                        let userModel = UserModel(
                            email: user.email ?? correctEmail,
                            password: user.password ?? correctPass,
                            displayName: user.displayName,
                            birthDate: user.birthDate,
                            username: user.username,
                            gender: Int(user.gender)
                        )
                        ContainerDI.shared.register(UserModel.self) { r in
                            return userModel
                        }.inObjectScope(.container)
                        
                        onSuccess(userModel)
                        onDone?()
                    } else {
                        onInvalidEmail?()
                        onDone?()
                    }
                }
            } else {
                print("Invalid Password")
                onInvalidPassword?()
                onDone?()
            }
        } else {
            print("Invalid Email")
            onInvalidEmail?()
            onDone?()
        }
         
        email = nil
        password = nil
    }
    
    func register(onSuccess: @escaping ((UserModel) -> Void), onDone: (() -> Void)? = nil, onInvalidEmail: (() -> Void)? = nil, onInvalidUsername: (() -> Void)? = nil, onInvalidPassword: (() -> Void)? = nil) {
         
        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
            if let correctPass = password, !correctPass.isEmpty {
                if let correctUsername = username, !correctPass.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                        let context = appDelegate.persistentContainer.viewContext
                        if let user = self.dataController?.addUser(username: correctUsername, email: correctEmail, password: correctPass, context: context) {
                            
                            let userModel = UserModel(
                                email: user.email ?? correctEmail,
                                password: user.password ?? correctPass,
                                displayName: user.displayName,
                                birthDate: user.birthDate,
                                username: user.username,
                                gender: Int(user.gender)
                            )
                            ContainerDI.shared.register(UserModel.self) { r in
                                return userModel
                            }.inObjectScope(.container)
                            
                            onSuccess(userModel)
                            onDone?()
                        }
                    }
                } else {
                    print("Invalid Username")
                    onInvalidUsername?()
                    onDone?()
                }
            } else {
                print("Invalid Password")
                onInvalidPassword?()
                onDone?()
            }
        } else {
            print("Invalid Email")
            onInvalidEmail?()
            onDone?()
        }
        
        email = nil
        password = nil
        username = nil
        
    }
}
