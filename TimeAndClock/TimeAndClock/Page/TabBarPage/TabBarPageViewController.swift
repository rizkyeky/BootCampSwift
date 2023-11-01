//
//  TabBarPageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit
import WidgetKit

class TabBarPageViewController: UITabBarController {

    let home = UINavigationController(rootViewController: HomePageViewController())
    let profile = UINavigationController(rootViewController: ProfilePageViewController())
    let setting = UINavigationController(rootViewController: SettingPageViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureUITabBarItems()
        
//        let appearance = UITabBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.backgroundEffect = UIBlurEffect(style: .regular)
        
//        if #available(iOS 15.0, *) {
//            self.tabBar.standardAppearance = appearance
//            self.tabBar.scrollEdgeAppearance = appearance
//        } else {
//
//        }
        
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
        home.tabBarItem = UITabBarItem(title: "Home", image: SFIconImage.home, tag: 0)
        setting.tabBarItem = UITabBarItem(title: "Setting", image: SFIconImage.system, tag: 1)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: SFIconImage.profile, tag: 2)
        
        UITabBarItem.appearance().setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes ([NSAttributedString.Key.foregroundColor: AppColor.base!], for: .selected)
        
        UITabBar.appearance().tintColor = AppColor.base
        self.tabBar.backgroundColor = .white
    }
        
    func configureTabBar() {
        setViewControllers([home, profile, setting], animated: true)
    }

}
