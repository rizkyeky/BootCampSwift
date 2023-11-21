//
//  HomeTableViewCell3.swift
//  CinemaTix
//
//  Created by Eky on 09/11/23.
//

import UIKit
import CenteredCollectionView
import Swinject

class HomeTableViewCell3: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    
    var collectionFlowLayout: CenteredCollectionViewFlowLayout!
    
    var movies: [MovieModel]?
    
    var onTap: ((Int) -> Void)?
    
    var isShowSkeleton = true
    
    static let height = 300
    static let heightItem = 300
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension HomeTableViewCell3: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollection() {
        collection.delegate = self
        collection.dataSource = self
        
        collection.registerCellWithNib(RecomCollectionViewCell.self)
        
        collectionFlowLayout = (collection.collectionViewLayout as! CenteredCollectionViewFlowLayout)
        
        collectionFlowLayout.itemSize = CGSize(width: 240, height: HomeTableViewCell3.heightItem)
        collectionFlowLayout.minimumLineSpacing = 16
        
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
    }
    
    func setupCell(_ cell: RecomCollectionViewCell, _ index: Int) {
        cell.onTap = { self.onTap?(index) }
        
        cell.title.text = movies?[index].title ?? "-"
        cell.card.backgroundColor = .clear
        
        let rating = movies?[index].voteAverage
        let strRating = String(format: "%.2f", rating ?? 0)
        cell.subtitle.text = rating != nil ? "Rating: \(strRating)" : "-"
        
        cell.card.hero.id = movies?[index].id?.formatted() ?? "CarouselHome1"
        
        if let backdropPath = movies?[index].backdropPath {
            let path = String(backdropPath.dropFirst())
            cell.card.backgroundView.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
        }
        
        if isShowSkeleton {
            cell.isSkeletonable = true
            cell.skeletonCornerRadius = 16
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = self.movies {
            return movies.count > 5 ? 5 : movies.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(forIndexPath: indexPath ) as RecomCollectionViewCell
        setupCell(cell, indexPath.row)
        return cell
    }
}
