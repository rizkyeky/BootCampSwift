//
//  Biometric.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import LocalAuthentication

class BiometricAuth {
    
    let context = LAContext()
    
    func authenticateUser(onSuccess: @escaping () -> Void, onError: ((Error?) -> Void)?) {
    
        var error: NSError?
        
        if let usernameDef = UserDefaults.standard.value(forKey: "username") as? String {
            if KeychainManager.isKeychainEmptyForUsername(username: usernameDef) {
                if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                    let reason = "Authentication required to open app"
                    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                        if success {
                            onSuccess()
                        } else {
                            if let error = evaluateError {
                                onError?(error)
                            } else {
                                onError?(NSError())
                            }
                        }
                    }
                } else {
                    onError?(NSError())
                }
            } else {
                onError?(NSError())
            }
        } else {
            onError?(NSError())
        }
    }

}
