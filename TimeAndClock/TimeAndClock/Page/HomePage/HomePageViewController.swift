//
//  HomePageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit

class HomePageViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupMainTableView()
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Home"
//        self.navigationItem.titleView?.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .automatic
        
        let addButton = UIBarButtonItem(image: SFIconImage.add, style: .plain, target: self, action: #selector(onTapAddButton))
        self.navigationItem.rightBarButtonItem = addButton
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = navigationController!.navigationBar.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        navigationController?.navigationBar.addSubview(blurEffectView)
//        navigationController?.navigationBar.sendSubviewToBack(blurEffectView)
    }
    
    func setupMainTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.registerCellWithNib(HomePageTableViewCell.self)
        mainTableView.allowsSelection = false
        mainTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc func onTapAddButton() {
        
        let nav = UINavigationController(rootViewController: AddPageViewController())
        
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
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomePageTableViewCell
        cell.leadingTitle.text = "TableCell \(indexPath.row)"
        
        cell.onTapOptionButton = {
            print("OptionButton TableCell \(indexPath.row)")
            let vc = PopUpViewController()
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            vc.onTapBarrier = {
                self.dismiss(animated: true)
            }
            
            self.present(vc, animated: true)
        }
        
        cell.onTapMainCard = {
            print("MainCard TableCell \(indexPath.row)")
        }
        
        return cell
    }
}
