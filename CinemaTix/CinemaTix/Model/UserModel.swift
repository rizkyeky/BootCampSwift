//
//  UserModel.swift
//  CinemaTix
//
//  Created by Eky on 20/11/23.
//

import Foundation
import FirebaseFirestoreInternal

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
    
    func toDict() -> [String: Any] {
        return [
            "email": self.email ?? "",
            "displayName": self.displayName ?? "",
            "birthDate": Timestamp(date: self.birthDate ?? Date()),
            "username": self.username ?? "",
            "gender": self.gender ?? 0,
            "wallet": self.wallet?.uuidString ?? ""
        ]
    }
    
    static func fromDict(_ dict: [String: Any?]) -> UserModel {
        let walletUUID = dict["wallet"] as? String
        return UserModel(
            email: dict["email"] as? String,
            displayName: dict["displayName"] as? String,
            birthDate: (dict["birthDate"] as? Timestamp)?.dateValue(),
            username: dict["username"] as? String,
            gender: dict["gender"] as? Int,
            wallet: walletUUID != nil ? UUID(uuidString: walletUUID!) : nil
        )
    }
}
