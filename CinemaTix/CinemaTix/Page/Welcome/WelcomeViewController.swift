//
//  WelcomeViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    let movieService = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInButton.setAnimateBounce()
    }
    
    
}

extension WelcomeViewController {
    func setupRegisterButton() {
        registerButton.setTitle("Create New Account", for: .normal)
        registerButton.setAnimateBounce()
        registerButton.addAction(UIAction { _ in
            self.onTapRegisterButton()
        }, for: .touchUpInside)
    }
    
    func onTapRegisterButton() {
        openBottomSheet(to: SigInViewController())
    }
}

extension WelcomeViewController {
    func setupSignInButton() {
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setAnimateBounce()
        signInButton.addAction(UIAction { _ in
            self.onTapSignInButton()
        }, for: .touchUpInside)
    }
    
    func onTapSignInButton() {
        openBottomSheet(to: SigInViewController())
        
        print("get getPlayingNow")
        movieService.getPlayingNow { result in
            switch result {
            case .success(let models):
                if ((models?.isEmpty) != nil) {
                    print(models?.count)
                    print(models?[0].title)
                }
            case .failure(let error):
                print(error.asAFError?.errorDescription)
            }
        }
    }

}


