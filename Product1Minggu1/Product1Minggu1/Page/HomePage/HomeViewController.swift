//
//  HomeViewController.swift
//  Product1Minggu1
//
//  Created by Eky on 27/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainTableView()
        
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupMainTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.registerCellWithNib(HomeTableCell.self)
        mainTableView.registerCellWithNib(HomeTableCell2.self)
        mainTableView.allowsSelection = false
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableCell
        cell1.mainLabel.text = "Table1Cell \(indexPath.row)"
        
        let cell2 = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableCell2
        cell2.mainLabel.text = "Table2Cell \(indexPath.row)"
        
        switch indexPath.row {
        case 0:
            return cell1
        case 1:
            return cell2
        default:
            return cell1
        }
    }
}
