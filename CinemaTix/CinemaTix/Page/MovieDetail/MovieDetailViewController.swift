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
import Hero

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var blurBox: UIView!
    
    @IBOutlet weak var spec: UILabel!
    @IBOutlet weak var castSection: CastSection!
    
    @IBOutlet weak var gradientBackdropBottom: GradientView!
    @IBOutlet weak var gradientBackdropTop: GradientView!
    
    var movie: MovieModel?
    var movieDetail: MovieDetailModel?
    
    let movieViewModel = ContainerDI.shared.resolve(MovieViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blurBox.addSubview(blurEffect)
        blurEffect.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self.blurBox)
        }
        
        bookButton.setTitle("Book Now", for: .normal)
        bookButton.setTitleColor(.black, for: .normal)
        bookButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        bookButton.makeCornerRadius(12)
        bookButton.setAnimateBounce()
        
        gradientBackdropTop.direction = .verticalReverse
        gradientBackdropTop.isHidden = true
        gradientBackdropBottom.isHidden = true
        
        self.hero.isEnabled = true
        backDropImage.hero.id = "\(movie?.id?.formatted() ?? "")backdrop"
//        bookButton.hero.id = "\(movie?.id?.formatted() ?? "")bookbtn"
//        blurBox.hero.id = "\(movie?.id?.formatted() ?? "")blur"
        
        bookButton.hero.modifiers = [.translate(y:48), .fade]
        blurBox.hero.modifiers = [.fade, .arc]
        navBar.hero.modifiers = [.cascade, .translate(x:100)]
        
        if let backdropPath = movie?.backdropPath {
            let path = String(backdropPath.dropFirst())
            backDropImage.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
            backDropImage.contentMode = .scaleAspectFill
        }
        
        spec.text = "13+ | "
        if let releaseDate = movie?.releaseDate, let rating = movie?.voteAverage {
            spec.text?.append("\(releaseDate) | ")
            spec.text?.append("Rating: \(String(format: "%.2f", rating))")
        }
        
        if let desc = movie?.overview {
            overviewText.text = desc
        }
        if let idMovie = movie?.id {
            self.castSection.isShowSkeleton = true
            movieViewModel.getCredit(id: idMovie) { _peoples in
                self.castSection.peoples = _peoples
                self.castSection.collection.reloadData()
                self.castSection.isShowSkeleton = false
            }
            
            movieViewModel.getDetailMovie(id: idMovie) { _movieDetail in
                self.movieDetail = _movieDetail
                self.spec.text?.append(" | \(formatMinutesToHoursAndMinutes(_movieDetail.runtime ?? 0))")
                let specText = self.spec.text
                self.spec.rx.text.onNext(specText)
            }
        }
        
        navBar.isHidden = false
        navBar.backgroundColor = .label
        navBar.title.text = movie?.title ?? "-"
        
        let shareBtn = UIButton(frame: .init(x: 0, y: 0, width: 30, height: 30))
        navBar.addSubview(shareBtn)
        shareBtn.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.right.equalTo(navBar).inset(16)
            make.centerY.equalTo(navBar.contain)
        }
        shareBtn.configuration = .plain()
        shareBtn.makeCornerRadiusRounded()
        shareBtn.setAnimateBounce()
        shareBtn.setImage(SFIcon.up?.resizeWith(size: CGSize(width: 24, height: 24)).reColor(.accent), for: .normal)
        shareBtn.setTitleColor(.accent, for: .normal)
        shareBtn.backgroundColor = .white
        shareBtn.addAction(UIAction { _ in
            
        }, for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollView.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navBar.opacityBackgroundDidScroll(scrollView, point: 30)
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
