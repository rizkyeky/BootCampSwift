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
        let coll = UICollectionView(frame: CGRect(x: 0, y: 0, width: 360, height: 480), collectionViewLayout: UICollectionViewFlowLayout())
        coll.isPagingEnabled = true
        coll.showsHorizontalScrollIndicator = false
        return coll
    }()
    
    private let viewModel: HomeViewModel
    
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
        
        addSubviews(collection, pageControl)
        collection.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(480)
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
            if let poster = movie.posterPath {
                cell.baseImage.loadFromUrl(url: TmdbApi.getImageURL(String(poster.dropFirst()), type: .w500))
            }
            cell.labelMovie = UILabel(text: movie.title ?? "__")
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

class HomeCarouselCell: BaseCollectionCell {
    
    public var baseImage = UIImageView() {
        didSet {
            baseImage.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            baseImage.contentMode = .scaleAspectFit
        }
    }
    
    public var labelMovie = UILabel() {
        didSet {
            labelMovie.font = .bold(32)
            labelMovie.textAlignment = .center
            labelMovie.numberOfLines = 0
        }
    }
    
    override func setup() {
        
        contentView.backgroundColor = .secondarySystemFill
        contentView.addSubview(baseImage)
        
        let baseLabel = UIView()
        baseImage.addSubview(baseLabel)
        baseLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(baseImage)
            make.width.equalTo(200)
            make.height.equalTo(100)
//            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        baseLabel.addSubview(labelMovie)
        labelMovie.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(baseLabel)
        }
        
        baseImage.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(contentView)
        }
    }
}
