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
        navBar.isHidden = false
        navBar.isHasBlurBox = true
        navBar.backButton.isHidden = true
        navBar.title.text = "Home"
        navBar.title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        let searchBtn = UIButton(frame: .init(x: 0, y: 0, width: 40, height: 40))
        navBar.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.right.equalTo(navBar).inset(16)
            make.centerY.equalTo(navBar.contain)
        }
        searchBtn.configuration = .plain()
        searchBtn.makeCornerRadiusRounded()
        searchBtn.setAnimateBounce()
        searchBtn.setImage(SFIcon.search?.resizeWith(size: CGSize(width: 24, height: 24)).reColor(.accent), for: .normal)
        searchBtn.setTitleColor(.accent, for: .normal)
        searchBtn.addAction(UIAction { _ in
            let searchVC = SearchViewController()
            self.navigationController?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(searchVC, animated: true)
        }, for: .touchUpInside)
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupMainTable() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.allowsSelection = false
        mainTable.separatorStyle = .none
        
        mainTable.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: view.bounds.width, height: 400))
        
        mainTable.registerCellWithNib(HomeTableViewCell.self)
        mainTable.registerCellWithNib(HomeTableViewCell2.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heights = [
            CGFloat(HomeTableViewCell.height),
            CGFloat(HomeTableViewCell2.height),
            CGFloat(HomeTableViewCell2.height),
        ]
        return heights[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tile = UIStackView(frame: .init(x: 0, y: 0, width: view.bounds.width, height: 52))
        let label = UILabel()
        let forwardBtn = UIButton(frame: .init(x: 0, y: 0, width: 36, height: 36))
        
        forwardBtn.setAnimateBounce()
        forwardBtn.setImage(SFIcon.forward, for: .normal)
        
        tile.axis = .horizontal
        tile.distribution = .fillProportionally
        tile.alignment = .center
        tile.addArrangedSubview(label)
        tile.addArrangedSubview(forwardBtn)
        
        switch section {
        case 0:
            label.text = LanguageStrings.playingNow.localized
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            forwardBtn.isHidden = true
        case 1:
            label.text = LanguageStrings.recommendedForYou.localized
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        case 2:
            label.text = LanguageStrings.upcoming.localized
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        default:
            break
        }
        
        return tile
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let animationDir = AnimationType.from(direction: .right, offset: 30.0)
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell
            
            cell.animate(animations: [animationDir], initialAlpha: 0.64, finalAlpha: 1, duration: TimeInterval(1))
            
            cell.onTapBookBtn = { i in
                if let detail = self.movieViewModel.playingNowMovies?[i] {
                    let bookNowVC = BookNowViewController()
                    bookNowVC.movie = detail
                    
                    self.navigationController?.hero.isEnabled = true
                    self.navigationController?.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(bookNowVC, animated: true)
                }
            }
            
            cell.isShowSkeleton = true
            self.movieViewModel.getPlayingNowMovies {
                cell.onTap = self.onTapPlayingNowCarouselCell
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
        case 1:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell2
            let animationDir = AnimationType.from(direction: .right, offset: 30.0)
            
            cell.animate(animations: [animationDir], initialAlpha: 0.64, finalAlpha: 1, duration: TimeInterval(1))
            
            cell.isShowSkeleton = true
            self.movieViewModel.getTopRatedMovies {
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
        default:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as HomeTableViewCell2
            
            cell.animate(animations: [animationDir], initialAlpha: 0.64, finalAlpha: 1, duration: TimeInterval(1))
            
            cell.isShowSkeleton = true
            self.movieViewModel.getUpComingMovies {
                
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navBar.scrollViewDidScroll(scrollView, point: 60)
    }
}

extension HomeViewController {
    func onTapPlayingNowCarouselCell(index: Int) {
        if let detail = self.movieViewModel.playingNowMovies?[index] {
            let movieDetailVC = MovieDetailViewController(movie: detail)
            
            self.navigationController?.hero.isEnabled = true
            self.navigationController?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
    func onTapTopRatedCarouselCell(index: Int) {
        if let detail = self.movieViewModel.topRatedMovies?[index] {
            let movieDetailVC = MovieDetailViewController(movie: detail)
            
            self.navigationController?.hero.isEnabled = true
            self.navigationController?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
    func onTapUpComingCarouselCell(index: Int) {
        if let detail = self.movieViewModel.upComingMovies?[index] {
            let movieDetailVC = MovieDetailViewController(movie: detail)
            
            self.navigationController?.hero.isEnabled = true
            self.navigationController?.hidesBottomBarWhenPushed = true
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

