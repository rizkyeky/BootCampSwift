//
//  HomeViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import CenteredCollectionView
import Swinject
import UIKitLivePreview
import ViewAnimator
import SkeletonView
import SPAlert
import PKHUD
import Hero

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    let movieViewModel = ContainerDI.shared.resolve(MovieViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainTable()
        setupNavigation()
        
        refreshControl.addAction(UIAction() { _ in
            self.getDataFromService() {
                self.refreshControl.endRefreshing()
            }
        }, for: .primaryActionTriggered)
        
        mainTable.addSubview(refreshControl)
        
//        let animationDir = AnimationType.from(direction: .bottom, offset: 40)
//        mainTable.animate(animations: [animationDir], initialAlpha: 0.48, finalAlpha: 1, duration: TimeInterval(0.64))
//        
//        self.hero.isEnabled = true
    }
    
    func getDataFromService(completion: (() -> Void)? = nil) {
        movieViewModel.getAllGenres {
            self.movieViewModel.getPlayingNowMovies {
                print("Get PlayingNowMovies Reload Main Table View")
                self.movieViewModel.getTopRatedMovies {
                    print("Get TopRatedMovies Reload Main Table View")
                    self.movieViewModel.getUpComingMovies {
                        print("Get UpComingMovies Reload Main Table View")
                        completion?()
                    }
                }
            }
        }
    }
    
    func setupNavigation() {
        navigationItem.title = "Playing Now"
        
        let searchButton = UIButton(configuration: .plain(), primaryAction: UIAction() { _ in
            self.navigationController?.pushViewController(SearchViewController(), animated: true)
        })
        searchButton.setTitle("Search", for: .normal)
        searchButton.setImage(SFIcon.search, for: .normal)
        let searchBarItem = UIBarButtonItem(customView: searchButton)
        
        let settingButton = UIButton(configuration: .plain(), primaryAction: UIAction() { _ in
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
        })
        
        settingButton.setImage(SFIcon.setting, for: .normal)
        let settingBarItem = UIBarButtonItem(customView: settingButton)
        
        let profileButton = UIButton(configuration: .plain(), primaryAction: UIAction() { _ in
            
        })
        profileButton.setImage(SFIcon.profile, for: .normal)
        let profileBarItem = UIBarButtonItem(customView: profileButton)
        
        navigationItem.rightBarButtonItems = [searchBarItem]
        navigationItem.leftBarButtonItems = [settingBarItem, profileBarItem]
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heights = [
            CGFloat(HomeTableViewCell2.height),
            CGFloat(HomeTableViewCell.height),
            CGFloat(HomeTableViewCell2.height),
            CGFloat(HomeTableViewCell3.height),
            CGFloat(HomeTableViewCell2.height),
            CGFloat(HomeTableViewCell3.height),
        ]
        return heights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let animationDir = AnimationType.from(direction: .right, offset: 30.0)
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell<HomeTableViewCell2>(forIndexPath: indexPath) as HomeTableViewCell2
            cell.label.text = "Playing Now"
            cell.label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            cell.button.isHidden = true
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell
            cell.animate(animations: [animationDir], initialAlpha: 0.64, finalAlpha: 1, duration: TimeInterval(1))
            
            cell.isShowSkeleton = true
            
            self.movieViewModel.getPlayingNowMovies {
                cell.onTap = self.onTapPlayingNowCarouselCell
                debugPrint("Reload Playing Now Carousel")
                cell.carousel.reloadData()
                
                cell.isShowSkeleton = false
            } onError: { error in
                AlertKitAPI.present(
                    title: error.asAFError?.errorDescription ?? "Error",
                    icon: AlertIcon.error,
                    style: .iOS17AppleMusic
                )
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell<HomeTableViewCell2>(forIndexPath: indexPath) as HomeTableViewCell2
            cell.label.text = "Recommanded for You"
            cell.onTap = {
                if let movies = self.movieViewModel.topRatedMovies {
                    let movieListVC = MovieListViewController()
                    movieListVC.titlePage = "Recommanded for You"
                    movieListVC.movies = movies
                    movieListVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(movieListVC, animated: true)
                }
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell3
            let animationDir = AnimationType.from(direction: .right, offset: 30.0)
            cell.animate(animations: [animationDir], initialAlpha: 0.64, finalAlpha: 1, duration: TimeInterval(1))
            
            cell.isShowSkeleton = true
            self.movieViewModel.getTopRatedMovies {
                debugPrint("Reload Top Rated Carousel")
                cell.onTap = self.onTapTopRatedCarouselCell
                cell.movies = self.movieViewModel.topRatedMovies
                cell.collection.reloadData()
                
                cell.isShowSkeleton = false
            } onError: { error in
                AlertKitAPI.present(
                    title: error.asAFError?.errorDescription ?? "Error",
                    icon: AlertIcon.error,
                    style: .iOS17AppleMusic
                )
            }
            
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell<HomeTableViewCell2>(forIndexPath: indexPath) as HomeTableViewCell2
            let animationDir = AnimationType.from(direction: .right, offset: 30.0)
            cell.animate(animations: [animationDir], initialAlpha: 0.64, finalAlpha: 1, duration: TimeInterval(1))
            cell.label.text = "Upcoming Movies"
            cell.onTap = {
                if let movies = self.movieViewModel.upComingMovies {
                    let movieListVC = MovieListViewController()
                    movieListVC.titlePage = "Upcoming Movies"
                    movieListVC.movies = movies
                    movieListVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(movieListVC, animated: true)
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell3
            cell.animate(animations: [animationDir], initialAlpha: 0.64, finalAlpha: 1, duration: TimeInterval(1))
            
            cell.isShowSkeleton = true
            self.movieViewModel.getUpComingMovies {
                debugPrint("Reload Up Coming Carousel")
                
                cell.onTap = self.onTapUpComingCarouselCell
                cell.movies = self.movieViewModel.upComingMovies
                cell.collection.reloadData()
                
                cell.isShowSkeleton = false
            } onError: { error in
                AlertKitAPI.present(
                    title: error.asAFError?.errorDescription ?? "Error",
                    icon: AlertIcon.error,
                    style: .iOS17AppleMusic
                )
            }
            
            return cell
        }
    }
    
    func onTapPlayingNowCarouselCell(index: Int) {
        if let detail = self.movieViewModel.playingNowMovies?[index] {
            let movieDetailVC = MovieDetailViewController()
            
            movieDetailVC.movie = detail
            movieDetailVC.hidesBottomBarWhenPushed = true

            self.navigationController?.hero.isEnabled = true
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
    func onTapTopRatedCarouselCell(index: Int) {
        if let detail = self.movieViewModel.topRatedMovies?[index] {
            let movieDetailVC = MovieDetailViewController()
            movieDetailVC.movie = detail
            movieDetailVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.hero.isEnabled = true
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
    func onTapUpComingCarouselCell(index: Int) {
        if let detail = self.movieViewModel.upComingMovies?[index] {
            let movieDetailVC = MovieDetailViewController()
            
            movieDetailVC.movie = detail
            movieDetailVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.hero.isEnabled = true
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
}

#if DEBUG && canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        HomeViewController()
            .preview()
            .device(.iPhone11)
    }
}

#endif

