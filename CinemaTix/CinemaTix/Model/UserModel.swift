//
//  UserModel.swift
//  CinemaTix
//
//  Created by Eky on 20/11/23.
//

import Foundation

struct UserModel {
    let id = UUID()
    
    let email: String
    let password: String
    
    var username: String?
    var displayName: String?
    var birthDate: Date?
    var gender: Int?
    var wallet: UUID?
    
    init(email: String, password: String, displayName: String? = nil, birthDate: Date? = nil, username: String? = nil, gender: Int? = nil, wallet: UUID? = nil) {
        self.username = username
        self.password = password
        self.displayName = displayName
        self.birthDate = birthDate
        self.email = email
        self.gender = gender
        self.wallet = wallet
    }
}
