//
//  SettingPageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit

class SettingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Setting"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
}
