//
//  Keychain.swift
//  CinemaTix
//
//  Created by Eky on 24/11/23.
//

import Foundation
import Security

class KeychainManager {
    private static let serviceName = "CinemaTixKeyChain"
    
    // Save username and password to Keychain
    static func saveCredentials(username: String, password: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: username,
            kSecValueData as String: password.data(using: .utf8)!
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Failed to save credentials to Keychain")
        }
    }
    
    // Retrieve password from Keychain for a given username
    static func getPasswordForUsername(username: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: username,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            print("Failed to retrieve password from Keychain")
            return nil
        }
    }
    
    static func isKeychainEmptyForUsername(username: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: username,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        return status == errSecItemNotFound
    }
}
