//
//  LaunchViewController.swift
//  CinemaTix
//
//  Created by Eky on 23/11/23.
//

import UIKit
import SPAlert
import Lottie
import Swinject
import netfox
import IQKeyboardManagerSwift
import FirebaseCore

class LaunchViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var slogan: UILabel!
    
    @IBOutlet weak var lottie: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottie.alpha = 0.0
        lottie.loopMode = .loop
        lottie.play()
        
        NFX.sharedInstance().start()
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        
        UIView.animate(withDuration: 0.48, delay: 0, options: .curveEaseOut, animations: {
            self.slogan.alpha = 0.0
            self.lottie.alpha = 1.0
            self.logo.transform = CGAffineTransform(translationX: 0, y: -200)
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.48) {
                let auth = ContainerDI.shared.resolve(AuthViewModel.self)!
                auth.checkActiveUser { user in
                    let firstVC: UIViewController
                    if let _ = user {
                        firstVC = TabBarViewController()
                    } else {
                        firstVC = WelcomeViewController()
                    }
                    self.navigationController?.setViewControllers([firstVC], animated: true)
                } onError: { error in
                    AlertKitAPI.present(
                        title: "Error Sign In: \(error.localizedDescription)",
                        icon: AlertIcon.error,
                        style: .iOS17AppleMusic,
                        haptic: .error
                    )
                    self.navigationController?.setViewControllers([WelcomeViewController()], animated: true)
                }
            }
        }
    }
}
