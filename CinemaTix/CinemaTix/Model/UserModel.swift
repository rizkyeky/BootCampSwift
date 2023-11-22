//
//  UserModel.swift
//  CinemaTix
//
//  Created by Eky on 20/11/23.
//

import Foundation

struct UserModel {
    let id = UUID()
    
    let email: String?
    
    var username: String?
    var displayName: String?
    var birthDate: Date?
    var gender: Int?
    var wallet: UUID?
    
    init(email: String?, displayName: String? = nil, birthDate: Date? = nil, username: String? = nil, gender: Int? = nil, wallet: UUID? = nil) {
        self.username = username
        self.displayName = displayName
        self.birthDate = birthDate
        self.email = email
        self.gender = gender
        self.wallet = wallet
    }
    
    static func fromDict(_ dict: [String: Any]) -> UserModel {
        let walletUUID = dict["wallet"]
        return UserModel(
            email: dict?["email"],
            displayName: dict?["displayName"],
            birthDate: Date.now,
            username: dict?["username"],
            gender: dict?["gender"],
            wallet: walletUUID != nil ? UUID(uuidString: walletUUID!) : nil
        )
    }
}
