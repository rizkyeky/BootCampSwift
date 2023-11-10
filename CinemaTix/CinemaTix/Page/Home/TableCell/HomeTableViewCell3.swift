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
    
    let movieViewModel = Container.shared.resolve(MovieViewModel.self)!
    
    var onTap: ((Int) -> Void)?
    
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
        
        let details = movieViewModel.topRatedMovies
        cell.title.text = details?[index].title ?? "-"
        
        let rating = details?[index].voteAverage
        let strRating = String(format: "%.2f", rating ?? 0)
        cell.subtitle.text = rating != nil ? "Rating: \(strRating)%" : "-"
        
        if let backdropPath = details?[index].backdropPath {
            let path = String(backdropPath.dropFirst())
            
            cell.card.backgroundView.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = self.movieViewModel.topRatedMovies {
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