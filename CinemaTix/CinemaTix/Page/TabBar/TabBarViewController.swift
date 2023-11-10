//
//  TabBarViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import Swinject

class TabBarViewController: UITabBarController {

    let home = UINavigationController(rootViewController: HomeViewController())
    let wallet = UINavigationController(rootViewController: WalletViewController())
    let transac = UINavigationController(rootViewController: TransacViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureUITabBarItems()
        
        Container.shared.register(UINavigationController.self) { r in
            return self.navigationController!
        }.inObjectScope(.container)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
        
        if let transacImage = SVGIcon.bag.getImage() {
            let img = transacImage.resizeWith(size: CGSize(width: 30, height: 30))
            transac.tabBarItem = UITabBarItem(title: "Transaction", image: img, tag: 2)
        }
        
//        let tabBarAppearance = UITabBarItem.appearance()
//        tabBarAppearance.setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: UIColor.label], for: .normal)
//        tabBarAppearance.setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: Color.accent!], for: .selected)

    }
        
    func configureTabBar() {
        setViewControllers([home, wallet, transac], animated: true)
    }
}
