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
    
    func signIn(onSuccess: @escaping ((User) -> Void), onInvalidEmail: (() -> Void)? = nil, onInvalidPassword: (() -> Void)? = nil) {
        
        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
            if let correctPass = password, !correctPass.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let context = appDelegate.persistentContainer.viewContext
                    if let user = self.dataController?.getUser(email: correctEmail, password: correctPass, context: context) {
                        onSuccess(user)
                    } else {
                        onInvalidEmail?()
                    }
                }
            } else {
                print("Invalid Password")
                onInvalidPassword?()
            }
        } else {
            print("Invalid Email")
            onInvalidEmail?()
        }
         
        email = nil
        password = nil
    }
    
    func register(onSuccess: @escaping ((User) -> Void), onInvalidEmail: (() -> Void)? = nil, onInvalidUsername: (() -> Void)? = nil, onInvalidPassword: (() -> Void)? = nil) {
         
        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
            if let correctPass = password, !correctPass.isEmpty {
                if let correctUsername = username, !correctPass.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                        let context = appDelegate.persistentContainer.viewContext
                        if let user = self.dataController?.addUser(username: correctUsername, email: correctEmail, password: correctPass, context: context) {
                            onSuccess(user)
                        }
                    }
                } else {
                    print("Invalid Username")
                    onInvalidUsername?()
                }
            } else {
                print("Invalid Password")
                onInvalidPassword?()
            }
        } else {
            print("Invalid Email")
            onInvalidEmail?()
        }
        
        email = nil
        password = nil
        username = nil
        
    }
}
