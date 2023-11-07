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
        let registerVC = RegisterViewController()
        registerVC.onTapRegisterButton = {
            self.dismiss(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }
        openBottomSheet(to: registerVC)
    }
}

extension WelcomeViewController {
    func setupSignInButton() {
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setAnimateBounce()
        signInButton.addAction(UIAction(handler: onTapSignInButton), for: .touchUpInside)
    }
    
    func onTapSignInButton(_ action: UIAction) {
        showFloatingPanel()
    }
}


extension WelcomeViewController: FloatingPanelControllerDelegate {
    
    func setupFloatingPanel() {
        floatingPanelController = FloatingPanelController()
        floatingPanelController.delegate = self
        
        floatingPanelController.surfaceView.makeCornerRadius(24)
        
        floatingPanelController.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        floatingPanelController.isRemovalInteractionEnabled = true
    }
    
    func showFloatingPanel() {
        let signInVC = SignInViewController()
        signInVC.onTapCloseButton = {
            self.dismiss(animated: true)
        }
        signInVC.onTapEmailButton = {
            self.dismiss(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }
        floatingPanelController.set(contentViewController: signInVC)
        present(floatingPanelController, animated: true, completion: nil)
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return SignInFloatingPanelLayout()
    }
    
    func floatingPanel(_ fpc: FloatingPanelController, animatorForPresentingTo state: FloatingPanelState) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: TimeInterval(0.24), curve: .easeOut)
    }
    
    func floatingPanel(_ fpc: FloatingPanelController, animatorForDismissingWith velocity: CGVector) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: TimeInterval(0.24), curve: .easeOut)
    }
}

