//
//  MovieListViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import UIKitLivePreview
import Hero

class MovieListViewController: BaseViewController {
    
    var movies: [MovieModel]?
    var titlePage: String?

    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.isHidden = false
        navBar.title.text = titlePage ?? "-"
        navBar.title.textColor = .clear
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.registerCellWithNib(MovieItemCell.self)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupCell(_ cell: MovieItemCell, _ index: Int) {
        cell.onTap = {
            if let movie = self.movies?[index] {
                let movieDetailVC = MovieDetailViewController()
                movieDetailVC.movie = movie
                movieDetailVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.hero.isEnabled = true
                self.navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        }
        
        cell.title.text = movies?[index].title ?? "-"
        
        cell.card.hero.id = movies?[index].id?.formatted() ?? "CarouselHome1"
    
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
        let cellWidth = ((collectionViewWidth) / 2) - 8
        return CGSize(width: cellWidth, height: Double(MovieItemCell.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navBar.scrollViewDidScroll(scrollView)
    }
}


#if DEBUG && canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct ListMovieViewController_Preview: PreviewProvider {
    static var previews: some View {
        MovieListViewController()
            .preview()
            .device(.iPhone11)
    }
}

#endif
