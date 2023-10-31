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
        
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    var onTapSubmitButton: (() -> Void)?
    @IBAction func didTapSubmitButton(_ sender: Any) {
        onTapSubmitButton?()
        
        guard let enteredUsername = usernameTextField.text, !enteredUsername.isEmpty else {
            showAlertDialog(title: "Wrong Username", message: "Please insert correct username")
            return
        }
        guard let enteredPassword = passwordTextField.text, !enteredPassword.isEmpty else {
            showAlertDialog(title: "Wrong Password", message: "Please insert correct password")
            return
        }
        
        self.navigationController?.pushViewController(TabBarPageViewController(), animated: true)
    }
    
    @IBAction func onChangedSwitchDarkMode(_ sender: Any) {
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
