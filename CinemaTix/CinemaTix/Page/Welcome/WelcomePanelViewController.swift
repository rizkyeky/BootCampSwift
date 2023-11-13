//
//  SignInViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import SnapKit

class WelcomePanelViewController: UIViewController {

    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var onTapCloseButton: (() -> Void)?
    var onTapAppleButton: (() -> Void)?
    var onTapGoolgeButton: (() -> Void)?
    var onTapEmailButton: (() -> Void)?
    
    let movieService = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppleButton()
        setupGoogleButton()
        setupEmailButton()
        setupCloseButton()
    }
}

extension WelcomePanelViewController {
    func setupAppleButton() {
        appleButton.setTitle("Sign In with Apple", for: .normal)
        appleButton.setTitleColor(.label, for: .normal)
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
        appleButton.addAction(UIAction() { _ in
            self.onTapAppleButton?()
        }, for: .touchUpInside)
    }
}

extension WelcomePanelViewController {
    func setupGoogleButton() {
        googleButton.setTitle("Sign In with Google", for: .normal)
        googleButton.setTitleColor(.label, for: .normal)
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
        googleButton.addAction(UIAction() { _ in
            self.onTapGoolgeButton?()
        }, for: .touchUpInside)
    }
}

extension WelcomePanelViewController {
    func setupEmailButton() {
        emailButton.setTitle("Sign In with Email", for: .normal)
        emailButton.setTitleColor(.label, for: .normal)
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
        emailButton.addAction(UIAction() { _ in
            self.onTapEmailButton?()
        }, for: .touchUpInside)
    }
}


extension WelcomePanelViewController {
    
    func setupCloseButton() {
        closeButton.addAction(UIAction(handler: didTapCloseButton), for: .touchUpInside)
    }
    
    func didTapCloseButton(_ sender: UIAction) {
        onTapCloseButton?()
    }
}