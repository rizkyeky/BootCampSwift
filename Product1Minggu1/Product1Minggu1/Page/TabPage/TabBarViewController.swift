//
//  TabBarViewController.swift
//  Product1Minggu1
//
//  Created by Eky on 30/10/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let home = UINavigationController(rootViewController: HomeViewController())
    let profile = UINavigationController(rootViewController: ProfileViewController())
    let setting = UINavigationController(rootViewController: ShareViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureUITabBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureUITabBarItems() {
        home.tabBarItem = UITabBarItem(title: "Home", image: SFIconImage.homeSymbol, tag: 0)
        setting.tabBarItem = UITabBarItem(title: "Favorite", image: SFIconImage.systemSymbol, tag: 1)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: SFIconImage.profileSymbol, tag: 2)
        
        UITabBarItem.appearance().setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .selected)
        
        UITabBar.appearance().tintColor = UIColor.systemBlue
        self.tabBar.backgroundColor = UIColor.white
    }
        
    func configureTabBar() {
        setViewControllers([home,setting,profile], animated: true)
    }
}
                                
