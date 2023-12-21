//
//  ProfileViewController.swift
//  CinemaTix
//
//  Created by Eky on 21/12/23.
//
import UIKit

class ProfileViewController: BaseViewController {
    
    let table: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let profileItems = [["Name", "Username", "Email", "Phone", "Gender", "Date of Birth"], ["Dark Mode", "Gender", "Interests", "Bio", "Settings"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        table.register(ProfileTableCell.self)
    }
    
    override func setupConstraints() {
        view.addSubview(table)
        
        table.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self.view)
        }
    }
    
    override func setupNavBar() {
        navigationItem.title = LanguageStrings.profile.localized
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ProfileTableCell
        cell.label.text = profileItems[indexPath.section][indexPath.row]
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class ProfileTableCell: BaseTableCell {
    
    private let base = UIView()
    public let label = UILabel()
    
    override func setup() {
        contentView.addSubview(base)
        base.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
            make.height.equalTo(40)
        }
        label.font = .medium(16)
        base.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(base)
            make.left.right.equalTo(base).inset(16)
        }
    }
}
