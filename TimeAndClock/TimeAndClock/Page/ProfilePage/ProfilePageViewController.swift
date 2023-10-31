//
//  ProfilePageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit

class ProfilePageViewController: UIViewController {
    
    @IBOutlet weak var backgroundProfile: UIView!
    @IBOutlet weak var avaProfile: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        backgroundProfile.clipsToBounds = true
        backgroundProfile.layer.cornerRadius = 8
        backgroundProfile.layer.borderWidth = 0.5
        backgroundProfile.layer.borderColor = UIColor.separator.cgColor
        
        avaProfile.clipsToBounds = true
        avaProfile.layer.cornerRadius = (avaProfile.frame.size.width / 2)
        avaProfile.layer.borderWidth = 6.0
        avaProfile.layer.borderColor = AppColor.base?.cgColor
        
        editButton.setTitle("", for: .normal)
        shareButton.setTitle("", for: .normal)
    }
    
    
}
