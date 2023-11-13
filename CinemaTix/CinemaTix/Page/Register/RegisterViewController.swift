//
//  RegisterViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject

class RegisterViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: RegisterTextField!
    @IBOutlet weak var emailTextField: RegisterTextField!
    @IBOutlet weak var passwordTextField: RegisterTextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    var onTapRegisterButton: (() -> Void)?
    
    let authViewModel = ContainerDI.shared.resolve(AuthViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelButton()
        
        setupUsernameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        
        setupRegisterButton()
    }
    
    func setupCancelButton() {
        navigationItem.title = "Register"
        
        let cancelButton = UIBarButtonItem(title: "Cancel")
        cancelButton.primaryAction = UIAction() { action in
            self.dismiss(animated: true)
        }
        navigationItem.setLeftBarButton(cancelButton, animated: true)
    }
    
    func setupUsernameTextField() {
        usernameTextField.mainLabel.text = "Username"
        usernameTextField.textField.placeholder = "Input username"
        
        usernameTextField.textField.rx.text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
            .map { $0 + ".00"}
            .subscribe { [weak self] text in
                guard let self = self else {return}
                authViewModel.username = text
            
            }.disposed(by: disposeBag)
    }
    
    func setupEmailTextField() {
        emailTextField.mainLabel.text = "Email"
        emailTextField.textField.placeholder = "Input email"
        
        emailTextField.textField.rx.text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
            .subscribe { [weak self] text in
                guard let self = self else {return}
                authViewModel.email = text
            }.disposed(by: disposeBag)
    }
    
    func setupPasswordTextField() {
        passwordTextField.mainLabel.text = "Password"
        passwordTextField.textField.placeholder = "Input pasword"
        passwordTextField.activateObsecure()
        
        passwordTextField.textField.rx.text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
//            .map { $0 + ".00"}
            .subscribe { [weak self] text in
                guard let self = self else {return}
                authViewModel.password = text
        }.disposed(by: disposeBag)
    }
    
    func setupRegisterButton() {
        registerBtn.setAnimateBounce()
        registerBtn.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            authViewModel.register() { user in
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }.disposed(by: disposeBag)
        registerBtn.addAction(UIAction() { action in
            self.onTapRegisterButton?()
        }, for: .touchUpInside)
        
    }
}
