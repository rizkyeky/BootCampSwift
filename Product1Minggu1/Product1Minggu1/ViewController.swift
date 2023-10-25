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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundProfile.backgroundColor = .white
        backgroundProfile.layer.cornerRadius = 24
        backgroundProfile.layer.shadowColor = UIColor.systemGray.cgColor
        backgroundProfile.layer.shadowOpacity = 0.2
        backgroundProfile.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundProfile.layer.shadowRadius = 4
        
        avaProfile.clipsToBounds = true
        avaProfile.layer.cornerRadius = avaProfile.frame.size.width / 2
        avaProfile.layer.borderWidth = 8.0
        avaProfile.layer.borderColor = UIColor.systemBlue.cgColor
        
        cardList.layer.cornerRadius = 24
        cardList.layer.shadowColor = UIColor.systemGray.cgColor
        cardList.layer.shadowOpacity = 0.2
        cardList.layer.shadowOffset = CGSize(width: 2, height: 2)
        cardList.layer.shadowRadius = 4
    }
}

