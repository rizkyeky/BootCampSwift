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
    
    let authViewModel = ContainerDI.shared.resolve(AuthViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sign In with Email"
        
        emailInput.mainLabel.text = "Email"
        passwordInput.mainLabel.text = "Password"
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setAnimateBounce()
        
        submitButton.addAction(UIAction() { _ in
            self.authViewModel.signIn() { [weak self] user in
                guard let self = self else {return}
                SVProgressHUD.show()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    SVProgressHUD.dismiss()
                    self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                }
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
