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
            "",
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
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    // set custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SettingPageTableViewCell
        let option = settingOptions[indexPath.section][indexPath.row]
        cell.button.setTitle(option, for: .normal)
        cell.button.layer.cornerRadius = 0
        cell.button.makeCornerRadius(0)
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            let cellDarkmode = tableView.dequeueReusableCell(forIndexPath: indexPath) as DarkModeTableViewCell
            cellDarkmode.button.layer.cornerRadius = 0
            cellDarkmode.button.makeCornerRadius(0)
            return cellDarkmode
        }
        
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.onTap = {
                self.showActionSheet()
            }
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
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Action Sheet Title", message: "Select an option", preferredStyle: .actionSheet)

        // Add actions
        actionSheet.addAction(UIAlertAction(title: "Option 1", style: .default, handler: { action in
            // Handle Option 1 selection
            print("Option 1 selected")
        }))

        actionSheet.addAction(UIAlertAction(title: "Option 2", style: .default, handler: { action in
            // Handle Option 2 selection
            print("Option 2 selected")
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Present the Action Sheet
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(actionSheet, animated: true, completion: nil)
    }
}
