//
//  SignInViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appleButton.setTitle("Sign In with Apple", for: .normal)
        googleButton.setTitle("Sign In with Google", for: .normal)
        emailButton.setTitle("Sign In with Email", for: .normal)
        
        appleButton.setAnimateBounce()
        googleButton.setAnimateBounce()
        emailButton.setAnimateBounce()
    }
}

