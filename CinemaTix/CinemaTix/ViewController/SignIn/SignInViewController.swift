//
//  SignInViewController.swift
//  CinemaTix
//
//  Created by Eky on 12/12/23.
//

import UIKit

class SignInViewController: BaseViewController {
    
    let onTap: (() -> Void)?
    
    init(onTap: (() -> Void)? = nil) {
        self.onTap = onTap
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let submitButton = FilledButton(title: "Submit")
    private let faceIDButton = TintedButton(title: "", icon: AppSVGIcon.faceId.getImage())
    
    private let emailField = FormTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordField = FormTextField(placeholder: "Password", keyboardType: .emailAddress, isPassword: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.addAction(UIAction { _ in
            self.dismiss(animated: true)
            self.onTap?()
        }, for: .touchUpInside)
    }
    
    override func setupNavBar() {
        navigationItem.title = "Sign In"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: TextButton(withTitle: "Cancel", size: .init(width: 60, height: 40)) {
            self.dismiss(animated: true)
        })
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.addHeader()
        }
    }
    
    override func setupConstraints() {
        view.addSubviews(emailField, passwordField, submitButton, faceIDButton)
        
        emailField.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        passwordField.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.emailField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        submitButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.passwordField.snp.bottom).offset(32)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
        
        faceIDButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.submitButton.snp.bottom).offset(32)
            make.width.height.equalTo(60)
        }

    }
}
