//
//  TabBarViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import SwiftUI
import Swinject

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = HomeViewController()
        let wallet = WalletViewController()
        let profile = {
            return UIHostingController(rootView: ProfileView() {
                self.navigationController?.setViewControllers([WelcomeViewController()], animated: true)
            })
        }()
    
        self.heroTabBarAnimationType = .pull(direction: .right)
        
        if let homeImage = SVGIcon.home.getImage() {
            let img = homeImage.resizeWith(size: CGSize(width: 30, height: 30))
            home.tabBarItem = UITabBarItem(title: LanguageStrings.home.localized, image: img, tag: 0)
        }
        
        if let walletImage = SVGIcon.wallet.getImage() {
            let img = walletImage.resizeWith(size: CGSize(width: 30, height: 30))
            wallet.tabBarItem = UITabBarItem(title: LanguageStrings.wallet.localized, image: img, tag: 1)
        }
        
        if let transacImage = SVGIcon.person.getImage() {
            let img = transacImage.resizeWith(size: CGSize(width: 30, height: 30))
            profile.tabBarItem = UITabBarItem(title: LanguageStrings.profile.localized, image: img, tag: 2)
        }
        
        setViewControllers([home, wallet, profile], animated: true)
    }
}
