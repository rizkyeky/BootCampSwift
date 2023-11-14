//
//  SignInViewController.swift
//  CinemaTix
//
//  Created by Eky on 11/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject
import SVProgressHUD

class SignInViewController: BaseViewController {

    @IBOutlet weak var emailInput: RegisterTextField!
    @IBOutlet weak var passwordInput: RegisterTextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var faceIdButton: UIButton!
    
    let authViewModel = ContainerDI.shared.resolve(AuthViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sign In with Email"
        
        emailInput.mainLabel.text = "Email"
        passwordInput.mainLabel.text = "Password"
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setAnimateBounce()
        
        faceIdButton.setAnimateBounce()
        faceIdButton.addAction(UIAction() { _ in
            self.authViewModel.biometric?.authenticateUser() { isSuccess in
                if isSuccess {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                    }
                } else {
                    self.showAlertOK(title: "Invalid Biometric", message: "This app does not get permission for biometric")
                }
            }
        }, for: .touchUpInside)
        
        submitButton.addAction(UIAction() { _ in
            SVProgressHUD.show()
            self.authViewModel.signIn() { [weak self] user in
                guard let self = self else {return}
                SVProgressHUD.dismiss()
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            } onInvalidEmail: {
                SVProgressHUD.dismiss()
                self.showAlertOK(title: "Invalid Email", message: "Please input correct email")
            } onInvalidPassword: {
                SVProgressHUD.dismiss()
                self.showAlertOK(title: "Invalid Password", message: "Please input correct password")
            }
            
        }, for: .touchUpInside)
        
        emailInput.textField.rx.text
            .compactMap { $0 }
            .filter { $0.isEmpty || $0.count > 4 }
            .subscribe { [weak self] text in
                guard let self = self else {return}
                self.authViewModel.email = text
            }
            .disposed(by: disposeBag)
        
        passwordInput.activateObsecure()
        passwordInput.textField.rx.text
            .compactMap { $0 }
            .filter { $0.isEmpty || $0.count > 4 }
            .subscribe { [weak self] text in
                guard let self = self else {return}
                self.authViewModel.password = text
            }
            .disposed(by: disposeBag)
    }
}
