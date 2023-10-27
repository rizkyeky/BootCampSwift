//
//  LoginViewController.swift
//  Product1Minggu1
//
//  Created by Eky on 27/10/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onTapSubmit(_ sender: Any) {
        guard let enteredUsername = usernameInput.text, !enteredUsername.isEmpty else {
            showAlertDialog(title: "Wrong Username", message: "Please insert correct username")
            return
        }
        guard let enteredPassword = passwordInput.text, !enteredPassword.isEmpty else {
            showAlertDialog(title: "Wrong Password", message: "Please insert correct password")
            return
        }
        
        doLogin(username: enteredUsername, password: enteredPassword)
    }
    
    func doLogin(username: String, password: String) {
        submitButton.isEnabled = false
        submitButton.setTitle("Loading..", for: .normal)
        
        Task {
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            print("Username: \(username)")
            print("Password: \(password)")
        }
        
        submitButton.isEnabled = true
        submitButton.setTitle("Submit", for: .normal)
        
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    func showAlertDialog(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
