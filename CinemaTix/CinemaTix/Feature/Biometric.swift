//
//  Biometric.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import LocalAuthentication

class Biometric {
    
    let context = LAContext()
    
    func authenticateUser() {
    
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authentication required to access your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                if success {
                    print("Biometric authentication successful")
                } else {
                    if let error = evaluateError {
                        print("Biometric authentication error: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            print("Biometric authentication not available")
        }
    }

}
