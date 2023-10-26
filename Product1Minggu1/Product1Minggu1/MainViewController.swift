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
    
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundProfile.layer.cornerRadius = 8
//        backgroundProfile.layer.shadowColor = UIColor.systemGray.cgColor
//        backgroundProfile.layer.shadowOpacity = 0.2
//        backgroundProfile.layer.shadowOffset = CGSize(width: 2, height: 2)
//        backgroundProfile.layer.shadowRadius = 4
        backgroundProfile.layer.borderWidth = 0.5
        backgroundProfile.layer.borderColor = UIColor.separator.cgColor
        
        avaProfile.clipsToBounds = true
        avaProfile.layer.cornerRadius = avaProfile.frame.size.width / 2
        avaProfile.layer.borderWidth = 6.0
        avaProfile.layer.borderColor = UIColor.systemBlue.cgColor
        
        cardList.layer.cornerRadius = 8
        cardList.layer.borderWidth = 0.5
        cardList.layer.borderColor = UIColor.separator.cgColor
//        cardList.layer.shadowColor = UIColor.systemGray.cgColor
//        cardList.layer.shadowOpacity = 0.2
//        cardList.layer.shadowOffset = CGSize(width: 2, height: 2)
//        cardList.layer.shadowRadius = 4
        switchDarkMode.setOn(isDarkMode, animated: false)
        
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
    
    var isDarkMode = false
    @IBOutlet weak var switchDarkMode: UISwitch!
    
    @IBAction func onTapDarkMode(_ sender: Any) {
        isDarkMode.toggle()
        switchDarkMode.setOn(isDarkMode, animated: true)
    }
    
    @IBAction func onChangedSwitchDarkMode(_ sender: Any) {
        
    }
    
    
    @IBAction func onTapLogout(_ sender: Any) {
        let alertController = UIAlertController(title: "Alert Title", message: "This is a simple alert", preferredStyle: .alert)

        // Add an action to the alert (a button)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

