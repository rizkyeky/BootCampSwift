//
//  HomePageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupMainTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.registerCellWithNib(HomePageTableViewCell.self)
        mainTableView.allowsSelection = false
    }
    
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomePageTableViewCell
        cell.mainLabel.text = "Table1Cell \(indexPath.row)"
        
        return cell
    }
}
