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
    }
    
    func setupMainTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.registerCellWithNib(HomeTableCell.self)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableCell
        cell.mainLabel.text = "TableCell \(indexPath.row)"
        return cell
    }
}
