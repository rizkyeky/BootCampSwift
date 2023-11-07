//
//  TabBarViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    let home = UINavigationController(rootViewController: HomeViewController())
    let wallet = UINavigationController(rootViewController: WalletViewController())
    let transac = UINavigationController(rootViewController: TransacViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureUITabBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func configureUITabBarItems() {
        if let homeImage = SVGIcon.home.getImage() {
            home.tabBarItem = UITabBarItem(title: "Home", image: homeImage, tag: 0)
        }
        
        wallet.tabBarItem = UITabBarItem(title: "Wallet", image: SVGIcon.wallet.getImage(), tag: 1)
        transac.tabBarItem = UITabBarItem(title: "Transaction", image: SVGIcon.bag.getImage(), tag: 2)
        
        UITabBarItem.appearance().setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: UIColor.label], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: Color.accent!], for: .selected)

    }
        
    func configureTabBar() {
        setViewControllers([home, wallet, transac], animated: true)
    }
    
    
}
