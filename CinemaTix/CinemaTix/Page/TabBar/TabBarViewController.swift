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

    let home = HomeViewController()
    let wallet = WalletViewController()
//    let profile = SettingViewController()
    let profile = UIHostingController(rootView: ProfileView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.heroTabBarAnimationType = .pull(direction: .right)
        
        configureTabBar()
        configureUITabBarItems()
    }

    func configureUITabBarItems() {
        if let homeImage = SVGIcon.home.getImage() {
            let img = homeImage.resizeWith(size: CGSize(width: 30, height: 30))
            home.tabBarItem = UITabBarItem(title: "Home", image: img, tag: 0)
        }
        
        if let walletImage = SVGIcon.wallet.getImage() {
            let img = walletImage.resizeWith(size: CGSize(width: 30, height: 30))
            wallet.tabBarItem = UITabBarItem(title: "Wallet", image: img, tag: 1)
        }
        
        if let transacImage = SVGIcon.person.getImage() {
            let img = transacImage.resizeWith(size: CGSize(width: 30, height: 30))
            profile.tabBarItem = UITabBarItem(title: "Profile", image: img, tag: 2)
        }
        
//        let tabBarAppearance = UITabBarItem.appearance()
//        tabBarAppearance.setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: UIColor.label], for: .normal)
//        tabBarAppearance.setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: Color.accent!], for: .selected)

    }
        
    func configureTabBar() {
        
        setViewControllers([home, wallet, profile], animated: true)
    }
}
