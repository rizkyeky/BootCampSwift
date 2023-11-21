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
import SPAlert
import PKHUD

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
        
        emailInput.textField.keyboardType = .emailAddress
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setAnimateBounce()
        
        faceIdButton.setAnimateBounce()
        faceIdButton.addAction(UIAction() { _ in
            self.authViewModel.biometric?.authenticateUser() { isSuccess in
                if isSuccess {
                    let loading = Loading()
                    loading.show()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                        loading.hide()
                        AlertKitAPI.present(
                            title: "Success Sign In with Face ID",
                            icon: AlertIcon.done,
                            style: .iOS17AppleMusic,
                            haptic: .success
                        )
                    }
                } else {
                    AlertKitAPI.present(
                        title: "Failed Sign In with Face ID",
                        icon: AlertIcon.error,
                        style: .iOS17AppleMusic,
                        haptic: .error
                    )
                }
            }
        }, for: .touchUpInside)
        
        submitButton.addAction(UIAction() { _ in
            let loading = Loading()
            loading.show()
            self.authViewModel.signIn() { [weak self] user in
                guard let self = self else {return}
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                loading.hide()
                AlertKitAPI.present(
                    title: "Success Sign In",
                    icon: AlertIcon.done,
                    style: .iOS17AppleMusic,
                    haptic: .success
                )
            } onDone: {

            } onInvalidEmail: {
                HUD.flash(.error, delay: 1.0)
                self.showAlertOK(title: "Invalid Email", message: "Please input correct email")
            } onInvalidPassword: {
                HUD.flash(.error, delay: 1.0)
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
