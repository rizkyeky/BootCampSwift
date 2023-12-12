//
//  HomeTableViewCell.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit
import CenteredCollectionView
import Swinject
import Kingfisher
import SkeletonView
import PKHUD
import Hero

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var carousel: UICollectionView!
    var carouselFlowLayout: CenteredCollectionViewFlowLayout!
    
    let movieViewModel = ContainerDI.shared.resolve(MovieViewModel.self)!
    
    var onTap: ((Int) -> Void)?
    var onTapBookBtn: ((Int) -> Void)?
    
    var isShowSkeleton: Bool?
    
    static let height = 228
    static let heightItem = 228
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCarousel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCarousel() {
        carousel.delegate = self
        carousel.dataSource = self
        
        carousel.registerCellWithNib(CarouselCell.self)
        
        carouselFlowLayout = (carousel.collectionViewLayout as! CenteredCollectionViewFlowLayout)
            
        carousel.decelerationRate = .fast
        
        carouselFlowLayout.itemSize = CGSize(width: 360, height: HomeTableViewCell.heightItem)
        carouselFlowLayout.minimumLineSpacing = 16

        carousel.showsVerticalScrollIndicator = false
        carousel.showsHorizontalScrollIndicator = false
    }
    
    func setupCell(_ cell: CarouselCell, _ index: Int) {
        cell.onTap = { self.onTap?(index) }
        
        cell.onTapBookBtn = { self.onTapBookBtn?(index) }
        
        let details = movieViewModel.playingNowMovies
        cell.title.text = details?[index].title ?? "-"
        cell.card.backgroundColor = .clear
        
        cell.card.hero.id = "\(details?[index].id?.formatted() ?? "")backdrop"
//        cell.bookButton.hero.id = "\(details?[index].id?.formatted() ?? "")bookbtn"
//        cell.boxBlur.hero.id = "\(details?[index].id?.formatted() ?? "")blur"
        
        let rating = details?[index].voteAverage
        let strRating = String(format: "%.2f", rating ?? 0)
        cell.subtitle.text = rating != nil ? "Rating: \(strRating)" : "-"
        
        if let backdropPath = details?[index].backdropPath {
            let path = String(backdropPath.dropFirst())
            cell.card.backgroundView.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
        }
        
        if isShowSkeleton ?? false {
            cell.skeletonCornerRadius = 16
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = self.movieViewModel.playingNowMovies {
            return movies.count > 5 ? 5 : movies.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = carousel.dequeueReusableCell(forIndexPath: indexPath) as CarouselCell
        setupCell(cell, indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPage = carouselFlowLayout.currentCenteredPage
        if currentPage != indexPath.row {
            carouselFlowLayout.scrollToPage(index: indexPath.row, animated: true)
        }
    }
    
}
