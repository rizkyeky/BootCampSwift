//
//  LoginPageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 31/10/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import LocalAuthentication

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var switchShowPass: UISwitch!
    
    var isShowPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = !isShowPassword
        switchShowPass.setOn(isShowPassword, animated: true)
        
        self.navigationItem.title = "Login"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    @IBAction func didTapSubmitButton(_ sender: Any) {
        
        let usernamePattern = "^[a-z]+$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernamePattern)
        
        guard let enteredUsername = usernameTextField.text, !enteredUsername.isEmpty, enteredUsername.count >= 3, usernameTest.evaluate(with: enteredUsername) else {
            showAlertDialog(title: "Wrong Username", message: "Please insert correct username")
            return
        }
        guard let enteredPassword = passwordTextField.text, !enteredPassword.isEmpty, enteredPassword.count >= 6 else {
            showAlertDialog(title: "Wrong Password", message: "Please insert correct password")
            return
        }
        
        submitButton.isUserInteractionEnabled = false
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        
        submitButton.addSubview(activityIndicator)
        submitButton.setTitle("", for: .disabled)
        
        activityIndicator.center = CGPoint(x: submitButton.bounds.width / 2, y: submitButton.bounds.height / 2)
        
        submitButton.isEnabled = false
        
        Task {
            
            singInFirebase(email: enteredUsername, password: enteredPassword)
            
            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
            
            submitButton.isEnabled = true
            submitButton.setTitle("Submit", for: .normal)
            
            self.navigationController?.setViewControllers([TabBarPageViewController()], animated: true)
        }
    }
    
    @IBAction func onChangedSwitch(_ sender: Any) {
        isShowPassword.toggle()
        passwordTextField.isSecureTextEntry = !isShowPassword
    }
    
    func showAlertDialog(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func singInFirebase(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            guard let user = authResult?.user else {
                print("User is not found")
                return
            }
            
            print("Success load user")
            
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
            }
        }
    }
    
    func authenticateUser() {
        let context = LAContext()

        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authentication required to access your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                if success {
                    // User authenticated successfully
                    print("Biometric authentication successful")
                    // Perform action after successful authentication
                } else {
                    if let error = evaluateError {
                        // Handle evaluation error or authentication failure
                        print("Biometric authentication error: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            // Biometric authentication not available, use a fallback mechanism (e.g., passcode)
            print("Biometric authentication not available")
        }
    }

}
