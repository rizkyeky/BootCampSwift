//
//  SettingPageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit

class SettingPageViewController: UIViewController {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var settingOptions: [[String]] = [
        [
            "Account",
            "Logout",
        ],
        [
            "Devices",
            "Notifications",
            "Storage Data",
            "Chats",
        ],
        [
            "Privacy",
            "Help",
            "Tell a Friend",
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Setting"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.registerCellWithNib(SettingPageTableViewCell.self)
        mainTableView.registerCellWithNib(DarkModeTableViewCell.self)
        mainTableView.allowsSelection = false
        mainTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension SettingPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    // set number of cell inside section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions[section].count
    }
    
    // set height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // set custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SettingPageTableViewCell
        let option = settingOptions[indexPath.section][indexPath.row]
        cell.button.setTitle(option, for: .normal)
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            let cellDarkmode = tableView.dequeueReusableCell(forIndexPath: indexPath) as DarkModeTableViewCell
            return cellDarkmode
        }
        
        return cell
    }
    
    // set total of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingOptions.count
    }
    
    // add section title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section+1)"
    }
    
    // set custom header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // set heigth of header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}
