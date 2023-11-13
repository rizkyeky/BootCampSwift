//
//  SettingViewController.swift
//  CinemaTix
//
//  Created by Eky on 13/11/23.
//

import UIKit
import SVProgressHUD

struct SettingOption {
    let label: String
    let action: (() -> Void)
    
    init(_ label: String, action: @escaping () -> Void = { }) {
        self.label = label
        self.action = action
    }
}

class SettingViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var settingOptions: [[SettingOption]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Setting"
        
        table.delegate = self
        table.dataSource = self
        table.registerCellWithNib(SettingBaseCell.self)
        table.registerCellWithNib(SettingDarkModeCell.self)
        
        settingOptions.append(contentsOf: [
            [
                SettingOption("Dark mode"),
                SettingOption("Account"),
                SettingOption("Logout") {
                    if let tabNavController = ContainerDI.shared.resolve(UINavigationController.self) {
                        self.showAlertOKCancel(title: "Logout", message: "Are you sure want to logout ?") {
                            SVProgressHUD.show()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                SVProgressHUD.dismiss()
                                tabNavController.setViewControllers([WelcomeViewController()], animated: true)
                            }
                        } onTapCancel: {
                            self.dismiss(animated: true)
                        }
                    }
                    
                },
            ],
            [
                SettingOption("Devices"),
                SettingOption("Notifications"),
                SettingOption("Storage Data"),
                SettingOption("Chats"),
            ],
            [
                SettingOption("Privacy"),
                SettingOption("Help"),
                SettingOption("Tell a Friend"),
            ]
        ])
    }
    
}
 
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    // set number of cell inside section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions[section].count
    }
    
    // set height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    // set custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            let cellDarkmode = table.dequeueReusableCell(forIndexPath: indexPath) as SettingDarkModeCell
            cellDarkmode.button.setTitle("Dark mode", for: .normal)
            return cellDarkmode
        } else {
            let cell = table.dequeueReusableCell(forIndexPath: indexPath) as SettingBaseCell
            let option = settingOptions[indexPath.section][indexPath.row]
            cell.button.setTitle(option.label, for: .normal)
            cell.button.addAction(UIAction() { _ in
                option.action()
            }, for: .touchUpInside)
            return cell
        }
    }
    
    // set total of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingOptions.count
    }
    
    // add section title
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section+1)"
//    }
    
    // set custom header
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView()
//    }
    
    // set heigth of header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
