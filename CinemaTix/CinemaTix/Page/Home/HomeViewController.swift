//
//  HomeViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import CenteredCollectionView
import Swinject

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    let movieViewModel = Container.shared.resolve(MovieViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainTable()
        setupNavigation()
        
        refreshControl.addAction(UIAction() { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("End refreshing")
                self.refreshControl.endRefreshing()
            }
        }, for: .touchUpInside)
        
        mainTable.addSubview(refreshControl)
        
        movieViewModel.getPlayingNowMovies {
            print("Reload Main Table View")
            self.mainTable.reloadData()
        }
    }
    
    func setupNavigation() {
        navigationItem.title = "Playing Now"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 40), primaryAction: UIAction() { _ in
            self.navigationController?.pushViewController(SearchViewController(), animated: true)
        })
        searchButton.configuration = .tinted()
        
//        searchButton.setImage(UIImage(named: "magnifyingglass"), for: .normal)
        searchButton.configuration?.imagePlacement = .trailing
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.configuration?.cornerStyle = .capsule
        searchButton.contentHorizontalAlignment = .fill
        
        let barButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
        
        navigationItem.rightBarButtonItems?.append(barButtonItem)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupMainTable() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.allowsSelection = false
        mainTable.separatorStyle = .none
        
        mainTable.registerCellWithNib(HomeTableViewCell.self)
        mainTable.registerCellWithNib(HomeTableViewCell2.self)
        mainTable.registerCellWithNib(HomeTableViewCell3.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heights = [
            CGFloat(HomeTableViewCell.height),
            CGFloat(HomeTableViewCell2.height),
            CGFloat(HomeTableViewCell3.height),
            CGFloat(HomeTableViewCell2.height),
            CGFloat(HomeTableViewCell3.height),
        ]
        return heights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell
            cell.onTap = onTapPlayingNowCarouselCell
            movieViewModel.onCompleteGetPlayingNowMovies.append({
                print("Reload First Table Cell")
                cell.carousel.reloadData()
            })
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell2
            cell.label.text = "Recommanded for You"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell3
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell2
            cell.label.text = "Upcoming Movies"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell3
            return cell
        }
    }
    
    func onTapPlayingNowCarouselCell(index: Int) {
        if let detail = self.movieViewModel.playingNowMovies?[index] {
            let movieDetailVC = MovieDetailViewController()
            movieDetailVC.detail = detail
            movieDetailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
//            if let tabBarNavigationController = Container.shared.resolve(UINavigationController.self) {
//                tabBarNavigationController.pushViewController(movieDetailVC, animated: true)
//            }
        }
    }
}
