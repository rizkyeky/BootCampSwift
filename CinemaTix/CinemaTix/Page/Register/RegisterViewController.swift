//
//  RegisterViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: RegisterTextField!
    @IBOutlet weak var emailTextField: RegisterTextField!
    @IBOutlet weak var passwordTextField: RegisterTextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    var username: String = ""
    var email: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelButton()
        
        setupUsernameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        
        setupRegisterButton()
    }
    
    func setupCancelButton() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        cancelButton.tintColor = .systemBlue
        cancelButton.primaryAction = UIAction() { action in
            self.dismiss(animated: true)
        }
        navigationItem.title = "Add"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.titleView?.backgroundColor = .clear
    }
    
    func setupUsernameTextField() {
        usernameTextField.mainLabel.text = "Username"
        usernameTextField.textField.placeholder = "Input username"
        usernameTextField.textField
            .rx
            .text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
            .map { $0 + ".00"}
            .subscribe { [weak self] text in
            guard let self = self else {return}
            self.username = text
            
        }.disposed(by: bag)
    }
    
    func setupEmailTextField() {
        emailTextField.mainLabel.text = "Email"
        emailTextField.textField.placeholder = "Input email"
        emailTextField.textField
            .rx
            .text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
            .map { $0 + ".00"}
            .subscribe { [weak self] text in
            guard let self = self else {return}
            self.username = text
            
        }.disposed(by: bag)
    }
    
    func setupPasswordTextField() {
        passwordTextField.mainLabel.text = "Password"
        passwordTextField.textField.placeholder = "Input pasword"
        passwordTextField.activateObsecure()
        passwordTextField.textField
            .rx
            .text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
            .map { $0 + ".00"}
            .subscribe { [weak self] text in
            guard let self = self else {return}
            self.username = text
            
        }.disposed(by: bag)
    }
    
    func setupRegisterButton() {
        registerBtn.setAnimateBounce()
        registerBtn.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            print(self.username)
        }.disposed(by: bag)
    }
}
