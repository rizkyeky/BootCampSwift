//
//  LoginPageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 31/10/23.
//

import UIKit

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
    
    var onTapSubmitButton: (() -> Void)?
    @IBAction func didTapSubmitButton(_ sender: Any) {
        onTapSubmitButton?()
        
        let usernamePattern = "^[a-z]+$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernamePattern)
        
        guard let enteredUsername = usernameTextField.text, !enteredUsername.isEmpty, enteredUsername.count >= 6, usernameTest.evaluate(with: enteredUsername) else {
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
            try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            print("Username: \(enteredUsername)")
            print("Password: \(enteredPassword)")
            
            submitButton.isEnabled = true
            submitButton.setTitle("Submit", for: .normal)
            
            self.navigationController?.pushViewController(TabBarPageViewController(), animated: true)
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
}
