//
//  WelcomeViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import FloatingPanel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var floatingPanelController: FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFloatingPanel()
        setupRegisterButton()
        setupSignInButton()
    }
}

extension WelcomeViewController {
    func setupRegisterButton() {
        registerButton.setTitle("Create New Account", for: .normal)
        registerButton.setAnimateBounce()
        registerButton.addAction(UIAction(handler: onTapRegisterButton), for: .touchUpInside)
    }
    
    func onTapRegisterButton(_ action: UIAction) {
        openBottomSheet(to: RegisterViewController())
    }
}

extension WelcomeViewController {
    func setupSignInButton() {
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setAnimateBounce()
        signInButton.addAction(UIAction(handler: onTapSignInButton), for: .touchUpInside)
    }
    
    func onTapSignInButton(_ action: UIAction) {
        floatingPanelController.show(animated: true)
    }

}


extension WelcomeViewController: FloatingPanelControllerDelegate {
    
    func setupFloatingPanel() {
        floatingPanelController = FloatingPanelController()
        floatingPanelController.delegate = self
        
        floatingPanelController.set(contentViewController: SignInViewController())
        floatingPanelController.addPanel(toParent: self)
        
        floatingPanelController.surfaceView.makeCornerRadius(16)
        
        floatingPanelController.hide()
    }
    
//    func floatingPanel(_ vc: FloatingPanelController, layoutFor, newCollection: UITraitCollection) -> FloatingPanelLayout? {
//        
//    }
    
}

