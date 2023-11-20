//
//  MovieDetailViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import Kingfisher
import UIKitLivePreview
import SkeletonView

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var castSection: CastSection!
    
    @IBOutlet weak var gradientBackdropBottom: GradientView!
    
    @IBOutlet weak var gradientBackdropTop: GradientView!
    
    var movie: MovieModel?
    var movieDetail: MovieDetailModel?
    
    let movieViewModel = ContainerDI.shared.resolve(MovieViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookButton.configuration = .filled()
        bookButton.setTitle("Book Now", for: .normal)
        bookButton.tintColor = .white
        bookButton.setAnimateBounce()
        bookButton.setTitleColor(.label, for: .normal)
        
        gradientBackdropTop.direction = .verticalReverse
        
        if let backdropPath = movie?.backdropPath {
            let path = String(backdropPath.dropFirst())
            backDropImage.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
            backDropImage.contentMode = .scaleAspectFill
        }
        
        if let desc = movie?.overview {
            overviewText.text = desc
        }
        if let idMovie = movie?.id {
            self.castSection.collection.showAnimatedSkeleton()
            movieViewModel.getCredit(id: idMovie) { _peoples in
                self.castSection.peoples = _peoples
                self.castSection.collection.hideSkeleton()
                self.castSection.collection.reloadData()
            }
        }
        
        navBar.isHidden = false
        navBar.title.text = movie?.title ?? "-"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollView.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationController?.navigationBar.overrideUserInterfaceStyle = .light
    }
}


#if DEBUG && canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct MovieDetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        MovieDetailViewController()
            .preview()
            .device(.iPhone11)
    }
}

#endif
