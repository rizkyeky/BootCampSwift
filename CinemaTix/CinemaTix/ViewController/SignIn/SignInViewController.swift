//
//  SignInViewController.swift
//  CinemaTix
//
//  Created by Eky on 12/12/23.
//

import UIKit

class SignInViewController: BaseViewController {

    private let submitButton: UIButton = {
        let button = FilledButton(title: "SUBMIT")
        return button
    }()
    
    private let emailField: UIView = {
        let field = UITextField(frame: .init(x: 0, y: 0, width: 300, height: 48))
        field.placeholder = "Email"
        field.keyboardType = .emailAddress
        return field
    }()
    
    private let passwordField: UIView = {
        let field = UITextField(frame: .init(x: 0, y: 0, width: 300, height: 48))
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavBar() {
        navigationItem.title = "Sign In"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: UIAction { _ in
            print("Cancel")
        })
    }
    
    override func setupConstraints() {
        view.addSubviews(emailField, passwordField, submitButton)
        
        emailField.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
        passwordField.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.emailField.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
        submitButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.passwordField.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }

    }
}
