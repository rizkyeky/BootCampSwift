//
//  ProfilePageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit

class ProfilePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
}
