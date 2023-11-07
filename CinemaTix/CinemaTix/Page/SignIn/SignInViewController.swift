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
    
    let movieService = MovieService()
    
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
    }
}

extension SignInViewController {
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
    }
}

extension SignInViewController {
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
        emailButton.addAction(UIAction(handler: didTapEmailButton), for: .touchUpInside)
    }
    
    func didTapEmailButton(_ action: UIAction) {
        dismiss(animated: true)
        Task {
            try await Task.sleep(nanoseconds: 1 * 100_000_000)
            print("go to tab bar")
            navigationController?.pushViewController(TabBarViewController(), animated: true)
        }
        
//        movieService.getPlayingNow { result in
//            switch result {
//            case .success(let model):
//                print(model?.count)
//            case .failure(let error):
//                print(error.asAFError?.errorDescription)
//            }
//        }
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
