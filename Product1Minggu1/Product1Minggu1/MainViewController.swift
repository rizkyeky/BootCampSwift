//
//  ViewController.swift
//  Product1Minggu1
//
//  Created by Eky on 25/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundProfile: UIView!
    @IBOutlet weak var avaProfile: UIImageView!
    @IBOutlet weak var cardList: UIView!
    
    var isDarkMode = false
    @IBOutlet weak var switchDarkMode: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundProfile()
        setupAvaProfile()
        setupCardList()
        
        switchDarkMode.setOn(isDarkMode, animated: false)
    }
    
    func setupBackgroundProfile() {
        
//        backgroundProfile.layer.shadowColor = UIColor.systemGray.cgColor
//        backgroundProfile.layer.shadowOpacity = 0.2
//        backgroundProfile.layer.shadowOffset = CGSize(width: 2, height: 2)
//        backgroundProfile.layer.shadowRadius = 4
        
        backgroundProfile.clipsToBounds = true
        backgroundProfile.layer.cornerRadius = 8
        backgroundProfile.layer.borderWidth = 0.5
        backgroundProfile.layer.borderColor = UIColor.separator.cgColor
    }
    
    func setupAvaProfile() {
        avaProfile.clipsToBounds = true
        avaProfile.layer.cornerRadius = avaProfile.frame.size.width / 2
        avaProfile.layer.borderWidth = 6.0
        avaProfile.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func setupCardList() {
        cardList.clipsToBounds = true
        cardList.layer.cornerRadius = 8
        cardList.layer.borderWidth = 0.5
        cardList.layer.borderColor = UIColor.separator.cgColor
//        cardList.layer.shadowColor = UIColor.systemGray.cgColor
//        cardList.layer.shadowOpacity = 0.2
//        cardList.layer.shadowOffset = CGSize(width: 2, height: 2)
//        cardList.layer.shadowRadius = 4
    }
    
    @IBAction func onTapSettingButtton(_ sender: Any) {
        let settingViewController = SettingViewController()
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @IBAction func onTapShareButton(_ sender: Any) {
        let shareViewController = ShareViewController()
        let nav = UINavigationController(rootViewController: shareViewController)
        
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true, completion: nil)
    }
    @IBAction func onTapEditProfile(_ sender: Any) {
        self.navigationController?.pushViewController(EditViewController(), animated: true)
    }
    
    @IBAction func onTapDarkMode(_ sender: Any) {
        turnOnOffDarkMode()
        isDarkMode.toggle()
        switchDarkMode.setOn(isDarkMode, animated: true)
    }
    
    @IBAction func onChangedSwitchDarkMode(_ sender: Any) {
        turnOnOffDarkMode()
        isDarkMode.toggle()
    }

    @IBAction func onTapLogout(_ sender: Any) {
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure want to log out", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            let loginViewController = LoginViewController()
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController {
    func turnOnOffDarkMode() {
        if (!isDarkMode) {
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
            }
        } else {
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
            }
        }
    }
}
