//
//  HomeCarousel.swift
//  CinemaTix
//
//  Created by Eky on 14/12/23.
//

import UIKit

class HomeCarousel: UIView {
    
    private let pageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.2)
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    private let collection = {
        let coll = UICollectionView(frame: CGRect(x: 0, y: 0, width: 360, height: 500), collectionViewLayout: UICollectionViewFlowLayout())
        coll.isPagingEnabled = true
        coll.showsHorizontalScrollIndicator = false
        return coll
    }()
    
    private let label = UILabel(text: LanguageStrings.playingNow.localized, font: .bold(32), textColor: .white)
    
    private let viewModel: HomeViewModel
    
    public var onTapCell: ((Int) -> Void)?
    
    init(viewModel: HomeViewModel, size: CGSize) {
        self.viewModel = viewModel
        
        super.init(frame: .init(origin: CGPoint(x: 0, y: 0), size: size))
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(cell: HomeCarouselCell.self)
        
        if let collFlowLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            collFlowLayout.scrollDirection = .horizontal
            collFlowLayout.itemSize = size
            collFlowLayout.minimumLineSpacing = 0
            collFlowLayout.minimumInteritemSpacing = 0
        }
        
        pageControl.numberOfPages = 3
        
        addSubviews(collection, pageControl, label)
        collection.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(500)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(self.collection)
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.bottom.equalTo(self.collection.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCarousel() {
        pageControl.numberOfPages = getMaxLen()
        collection.reloadData()
    }
    
    private func getMaxLen() -> Int {
       return min(5, viewModel.playingNowMovies?.count ?? 3)
    }
}

extension HomeCarousel: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMaxLen()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as HomeCarouselCell
        
        if let movie = viewModel.playingNowMovies?[indexPath.row] {
            cell.isLoading = false
            
            cell.onTap = {
                self.onTapCell?(indexPath.row)
            }
            
            if let poster = movie.posterPath {
                cell.baseImage.loadFromUrl(url: TmdbApi.getImageURL(String(poster.dropFirst()), type: .w500), usePlaceholder: true)
            }
            if let title = movie.title {
                cell.labelTitle.text = title
            }
            if let rate = movie.voteAverage, let date = movie.releaseDate {
                cell.labelSubtitle.text = movie.genres().joined(separator: ", ") + " • " + String(format: "%.1f", rate) + " • " + date
            }
            if let overview = movie.overview {
                cell.labelOverview.text = overview
            }
        } else {
            cell.isLoading = true
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

class HomeCarouselCell: BaseCollectionCell {
    
    public let baseImage = {
        let base = UIImageView()
        base.contentMode = .scaleToFill
        return base
    }()
    
    public let labelTitle = {
        let label = UILabel()
        label.font = .bold(24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    public let labelSubtitle = {
        let label = UILabel()
        label.font = .bold(16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.8)
        return label
    }()

    public let labelOverview = {
        let label = UILabel()
        label.font = .medium(14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.6)
        return label
    }()
    
    public var isLoading: Bool = false {
        didSet {
            baseGradient.isHidden = isLoading
        }
    }

    private let baseGradient = GradientView()
    
    override func setup() {
        
        contentView.addSubview(baseImage)
        baseImage.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(contentView)
        }
        
        baseImage.addSubview(baseGradient)
        baseGradient.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.bottom.equalTo(self.baseImage.snp.bottom)
            make.left.right.equalTo(self)
        }

        baseGradient.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(self.baseGradient.snp.top).offset(24)
            make.centerX.equalTo(self.baseGradient)
        }
        baseGradient.addSubview(labelSubtitle)
        labelSubtitle.snp.makeConstraints { make in
            make.centerX.equalTo(self.baseGradient)
            make.top.equalTo(labelTitle.snp.bottom).offset(4)
        }
        baseGradient.addSubview(labelOverview)
        labelOverview.snp.makeConstraints { make in
            make.centerX.equalTo(self.baseGradient)
            make.top.equalTo(labelSubtitle.snp.bottom).offset(4)
            make.width.equalTo(360)
            make.height.equalTo(60)
        }
        
    }
}
