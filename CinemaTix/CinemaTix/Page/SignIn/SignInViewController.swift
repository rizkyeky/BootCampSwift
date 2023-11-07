//
//  SignInViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {

    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var onTapCloseButton: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppleButton()
        setupGoogleButton()
        setupEmailButton()
        setupCloseButton()
    }
}

extension SignInViewController {
    func setupAppleButton() {
        appleButton.setTitle("Sign In with Apple", for: .normal)
        if let appleLogo = SVGIcon.apple.getImage() {
            let view = UIImageView(image: appleLogo)
            view.tintColor = .white
            appleButton.addSubview(view)
            view.snp.makeConstraints { make in
                make.width.height.equalTo(30)
                make.leftMargin.equalTo(16)
                make.centerY.equalTo(self.appleButton)
            }
        }
        appleButton.setAnimateBounce()
    }
}

extension SignInViewController {
    func setupGoogleButton() {
        googleButton.setTitle("Sign In with Google", for: .normal)
        if let googleLogo = SVGIcon.google.getImage() {
            let view = UIImageView(image: googleLogo)
            view.tintColor = .white
            googleButton.addSubview(view)
            view.snp.makeConstraints { make in
                make.width.height.equalTo(30)
                make.leftMargin.equalTo(16)
                make.centerY.equalTo(self.googleButton)
            }
        }
        googleButton.setAnimateBounce()
    }
}

extension SignInViewController {
    func setupEmailButton() {
        emailButton.setTitle("Sign In with Email", for: .normal)
        if let emailLogo = SVGIcon.email.getImage() {
            let view = UIImageView(image: emailLogo)
            view.tintColor = .white
            emailButton.addSubview(view)
            view.snp.makeConstraints { make in
                make.width.height.equalTo(30)
                make.leftMargin.equalTo(16)
                make.centerY.equalTo(self.emailButton)
            }
        }
        emailButton.setAnimateBounce()
    }
}


extension SignInViewController {
    
    func setupCloseButton() {
        closeButton.addAction(UIAction(handler: didTapCloseButton), for: .touchUpInside)
    }
    
    func didTapCloseButton(_ sender: UIAction) {
        onTapCloseButton?()
    }
}
