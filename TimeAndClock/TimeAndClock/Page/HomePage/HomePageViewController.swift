//
//  HomePageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit

class HomePageViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    
//    var popUp = PopUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupMainTableView()
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Home"
        self.navigationItem.titleView?.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        let addButton = UIBarButtonItem(image: SFIconImage.add, style: .plain, target: self, action: #selector(onTapAddButton))
        self.navigationItem.rightBarButtonItem = addButton
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func setupMainTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.registerCellWithNib(HomePageTableViewCell.self)
        mainTableView.allowsSelection = false
        mainTableView.separatorInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    @objc func onTapAddButton() {
        
        let vc = AddPageViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .pageSheet

        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.large()]
            }
            present(nav, animated: true, completion: nil)
        }
        
    }
    
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomePageTableViewCell
        cell.leadingTitle.text = "TableCell \(indexPath.row)"
        
        cell.onTapOptionButton = {
            print("OptionButton TableCell \(indexPath.row)")
        }
        
        cell.onTapMainCard = {
            print("MainCard TableCell \(indexPath.row)")
        }
        
        return cell
    }
}
