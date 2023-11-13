//
//  MovieListViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var movies: [MovieDetailModel]?
    var titlePage: String?

    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = titlePage ?? "-"
        navigationItem.backButtonDisplayMode = .minimal
        
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: nil), animated: true)
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.registerCellWithNib(MovieItemCell.self)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCell(_ cell: MovieItemCell, _ index: Int) {
//        cell.onTap = { self.onTap?(index) }
        
//        let details = movieViewModel.playingNowMovies
//        cell.title.text = details?[index].title ?? "-"
        
        let rating = movies?[index].voteAverage
        let strRating = String(format: "%.2f", rating ?? 0)
//        cell.subtitle.text = rating != nil ? "Rating: \(strRating)" : "-"
        
        if let backdropPath = movies?[index].backdropPath {
            let path = String(backdropPath.dropFirst())
            
            cell.card.backgroundView.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movies != nil {
            return movies!.count > 20 ? 20 : movies!.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(forIndexPath: indexPath) as MovieItemCell
        setupCell(cell, indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collection.bounds.width
        let cellWidth = (collectionViewWidth) / 2
        return CGSize(width: cellWidth, height: Double(MovieItemCell.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
