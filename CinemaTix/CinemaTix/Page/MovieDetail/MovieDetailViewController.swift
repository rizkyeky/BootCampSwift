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
    
    @IBOutlet weak var genreList: UIView!
    
   
    var movieDetail: MovieDetailModel?
    
    let movieViewModel = ContainerDI.shared.resolve(MovieViewModel.self)!
    
    let movie: MovieModel
    
    init(movie: MovieModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let attributedString = NSAttributedString(string: "Book Now", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: bookButton.titleLabel?.font.pointSize ?? UIFont.systemFontSize)])
        
        bookButton.setAttributedTitle(attributedString, for: .normal)
        bookButton.addAction(UIAction { _ in
            self.navigationController?.pushViewController(BookNowViewController(), animated: true)
        }, for: .touchUpInside)
        
        gradientBackdropTop.direction = .verticalReverse
        gradientBackdropTop.isHidden = true
        gradientBackdropBottom.isHidden = true
        
        self.hero.isEnabled = true
        backDropImage.hero.id = "\(movie.id?.formatted() ?? "")backdrop"
//        bookButton.hero.id = "\(movie?.id?.formatted() ?? "")bookbtn"
//        blurBox.hero.id = "\(movie?.id?.formatted() ?? "")blur"
        
        bookButton?.hero.modifiers = [.translate(y:48), .fade]
        blurBox?.hero.modifiers = [.fade, .arc]
        navBar.hero.modifiers = [.cascade, .translate(x:100)]
        
        if let backdropPath = movie.backdropPath {
            let path = String(backdropPath.dropFirst())
            backDropImage.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
            backDropImage.contentMode = .scaleAspectFill
        }
        
        spec.text = "13+ | "
        if let rating = movie.voteAverage {
            spec.text?.append("Rating: \(String(format: "%.2f", rating))")
        }
        
        if let desc = movie.overview {
            overviewText.text = desc
        }
        
        navBar.isHidden = false
        navBar.backgroundColor = .systemBackground
        navBar.isHasBlurBox = true
        navBar.title.textColor = .label
        navBar.title.text = movie.title ?? "-"
        
        let shareBtn = UIButton(frame: .init(x: 0, y: 0, width: 32, height: 32))
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
        shareBtn.backgroundColor = .secondarySystemFill
        shareBtn.addAction(UIAction { sender in
            
            let activityVC = UIActivityViewController(
                activityItems: [self.movie.title ?? "-", self.movie.backdropPath ?? "-"],
                applicationActivities: nil
            )
            
            activityVC.popoverPresentationController?.sourceView = shareBtn

            self.present(activityVC, animated: true, completion: nil)
            
        }, for: .touchUpInside)
        
        let rowGenre = UIStackView()
        rowGenre.axis = .horizontal
        rowGenre.distribution = .fill
        rowGenre.spacing = 8.0
        
        genreList.addSubview(rowGenre)
        rowGenre.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(self.genreList)
        }
        
        for _ in 0..<3 {
            let genreBox = UIView()
            genreBox.backgroundColor = .secondarySystemFill
            genreBox.makeCornerRadius(8)
            rowGenre.addArrangedSubview(genreBox)
            genreBox.snp.makeConstraints { make in
                make.width.equalTo(88)
                make.height.equalTo(rowGenre.snp.height)
            }
        }
        
        if let idMovie = movie.id {
            self.castSection.isShowSkeleton = true
            movieViewModel.getCredit(id: idMovie) { _peoples in
                self.castSection.peoples = _peoples
                self.castSection.collection.reloadData()
                self.castSection.isShowSkeleton = false
            }
            
            movieViewModel.getDetailMovie(id: idMovie) { _movieDetail in
                self.movieDetail = _movieDetail
                self.spec.text?.append(" | \((_movieDetail.runtime ?? 0).formatMinutesToHoursAndMinutes())")
                let specText = self.spec.text
                self.spec.rx.text.onNext(specText)
                
                if let releaseDate = self.movieDetail?.releaseDate {
                    let formatter1 = DateFormatter()
                    formatter1.dateFormat = "yyyy-MM-dd"
                    let date = formatter1.date(from: releaseDate)
                    
                    let formatter2 = DateFormatter()
                    formatter2.dateFormat = "dd, MMMM yyyy"
                    let dateStr = formatter2.string(from: date!)
                    
                    self.spec.text?.append("\n\(dateStr)")
                }
                
                rowGenre.arrangedSubviews.forEach { $0.removeFromSuperview() }
                if let genres = self.movieDetail?.genres {
                    let len = genres.count > 3 ? 3 : genres.count
                    for genre in genres[0..<len] {
                        let genreBox = UIView(frame: .init(x: 0, y: 0, width: 88, height: 32))
                        genreBox.backgroundColor = .secondarySystemFill
                        genreBox.makeCornerRadius(8)
                        
                        let label = UILabel()
                        label.text = genre.name ?? "-"
                        label.textColor = .label
                        
                        genreBox.addSubview(label)
                        label.snp.makeConstraints { make in
                            make.centerX.centerY.equalTo(genreBox)
                        }
                        
                        rowGenre.addArrangedSubview(genreBox)
                        genreBox.snp.makeConstraints { make in
                            make.width.equalTo(88)
                            make.height.equalTo(rowGenre.snp.height)
                        }
                    }
                }
            }
        }
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
        navBar.opacityBackgroundDidScroll(scrollView.contentOffset.y, point: 30, limit: 0.32)
    }
}

#if DEBUG && canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct MovieDetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        MovieDetailViewController(movie: .init(adult: nil, backdropPath: nil, genreIDS: nil, id: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: nil, video: nil, voteAverage: nil, voteCount: nil))
            .preview()
            .device(.iPhone11)
    }
}

#endif
