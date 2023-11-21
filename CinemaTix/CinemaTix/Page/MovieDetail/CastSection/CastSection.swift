//
//  CastSection.swift
//  CinemaTix
//
//  Created by Eky on 14/11/23.
//

import UIKit

class CastSection: UIView {

    @IBOutlet weak var collection: UICollectionView!
    
    var peoples: [People]?
    
    var isShowSkeleton = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        let view = self.loadNib()
        view.frame = self.bounds
        view.clipsToBounds = true
        self.addSubview(view)
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.registerCellWithNib(CastCell.self)
        
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
    }
}

extension CastSection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCell(_ cell: CastCell, _ index: Int) {
        cell.onTap = {
        }
        
        cell.title.text = peoples?[index].name ?? "-"
        
        if let backdropPath = peoples?[index].profilePath {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 200)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _peoples = peoples {
            return _peoples.count > 5 ? 5 : _peoples.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CastCell
        setupCell(cell, indexPath.row)
        return cell
    }
}
