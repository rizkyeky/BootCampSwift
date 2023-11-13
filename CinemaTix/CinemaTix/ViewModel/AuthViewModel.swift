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
    
    let dataController = ContainerDI.shared.resolve(DataController.self)
    
    func signIn(completion: @escaping ((User) -> Void)) {
        
        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
            if let correctPass = password, !correctPass.isEmpty {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let context = appDelegate.persistentContainer.viewContext
                if let user = dataController?.getUser(email: correctEmail, password: correctPass, context: context) {
                    completion(user)
                }
            } else {
                print("Invalid Password")
            }
        } else {
            print("Invalid Email")
        }
         
        email = nil
        password = nil
    }
    
    func register(completion: @escaping ((User) -> Void)) {
         
        if let correctEmail = email, !correctEmail.isEmpty, correctEmail.isValidEmail() {
            if let correctPass = password, !correctPass.isEmpty {
                if let correctUsername = username, !correctPass.isEmpty {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let context = appDelegate.persistentContainer.viewContext
                    if let user = dataController?.addUser(username: correctUsername, email: correctEmail, password: correctPass, context: context) {
                        completion(user)
                    }
                } else {
                    print("Invalid Username")
                }
            } else {
                print("Invalid Password")
            }
        } else {
            print("Invalid Email")
        }
        
        email = nil
        password = nil
        username = nil
        
    }
}
