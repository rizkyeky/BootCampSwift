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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureUITabBarItems() {
        home.tabBarItem = UITabBarItem(title: "Home", image: Icon.home, tag: 0)
        wallet.tabBarItem = UITabBarItem(title: "Wallet", image: Icon.system, tag: 1)
        transac.tabBarItem = UITabBarItem(title: "Transaction", image: Icon.profile, tag: 2)
        
        UITabBarItem.appearance().setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: UIColor.label], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: Color.base], for: .selected)

    }
        
    func configureTabBar() {
        setViewControllers([home, wallet, transac], animated: true)
    }
    
    
}
