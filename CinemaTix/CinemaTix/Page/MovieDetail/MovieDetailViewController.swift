//
//  MovieDetailViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
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

        navigationItem.title = movie?.title ?? "-"
        
        let backButton = UIButton(configuration: .gray(), primaryAction: UIAction() { _ in
        })
        backButton.setImage(SFIcon.back, for: .normal)
        backButton.setAnimateBounce()
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        
        if let backdropPath = movie?.backdropPath {
            let path = String(backdropPath.dropFirst())
            backDropImage.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
            backDropImage.contentMode = .scaleAspectFill
        }
        
        if let desc = movie?.overview {
            overviewText.text = desc
        }
        if let idMovie = movie?.id {
//            movieViewModel.getDetailMovie(id: idMovie) { detail in
//                self.movieDetail = detail
//            }
            movieViewModel.getCredit(id: idMovie) { _peoples in
                self.castSection.peoples = _peoples
                self.castSection.collection.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        
        if let heightNavBar = navigationController?.navigationBar.frame.height {
            scrollView.contentInset = UIEdgeInsets(top: -(heightNavBar+60), left: 0, bottom: 0, right: 0)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationController?.navigationBar.overrideUserInterfaceStyle = .light
    }
}
