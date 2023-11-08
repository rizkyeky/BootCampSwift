//
//  HomeViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import CenteredCollectionView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainTable()
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationItem.title = "Now Playing"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 40), primaryAction: UIAction() { _ in
            self.navigationController?.pushViewController(SearchViewController(), animated: true)
        })
        searchButton.configuration = .tinted()
//        searchButton.setImage(UIImage(named: "magnifyingglass")?.withTintColor(.label), for: .normal)
//        searchButton.configuration?.imagePlacement = .trailing
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.configuration?.cornerStyle = .capsule
        searchButton.contentHorizontalAlignment = .fill
        searchButton.setAnimateBounce()
        
        let barButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
        
        navigationItem.rightBarButtonItems?.append(barButtonItem)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupMainTable() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.registerCellWithNib(HomeTableViewCell.self)
        mainTable.allowsSelection = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell
        return cell
    }
    
    
    
}
