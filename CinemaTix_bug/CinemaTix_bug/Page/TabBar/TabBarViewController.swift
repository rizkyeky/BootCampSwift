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
        
        let homeImage = SVGIcon.home.getImage()
        home.tabBarItem = UITabBarItem(title: LanguageStrings.home.localized, image: homeImage.resizeWith(size: CGSize(width: 30, height: 30)), tag: 0)
        
        let walletImage = SVGIcon.wallet.getImage()
        wallet.tabBarItem = UITabBarItem(title: LanguageStrings.wallet.localized, image: walletImage.resizeWith(size: CGSize(width: 30, height: 30)), tag: 1)
        
        let transacImage = SVGIcon.person.getImage()
        profile.tabBarItem = UITabBarItem(title: LanguageStrings.profile.localized, image: transacImage.resizeWith(size: CGSize(width: 30, height: 30)), tag: 2)
        
        setViewControllers([home, wallet, profile], animated: true)
    }
}
