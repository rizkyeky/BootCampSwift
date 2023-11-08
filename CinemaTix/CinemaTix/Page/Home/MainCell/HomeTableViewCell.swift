//
//  HomeTableViewCell.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit
import CenteredCollectionView

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var carousel: UICollectionView!
    var carouselFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCarousel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCarousel() {
        carousel.delegate = self
        carousel.dataSource = self
        carousel.registerCellWithNib(CarouselCell.self)
        
        carouselFlowLayout = (carousel.collectionViewLayout as! CenteredCollectionViewFlowLayout)
            
        carousel.decelerationRate = .fast
        
        carouselFlowLayout.itemSize = CGSize(width: 360,height: 228)
        carouselFlowLayout.minimumLineSpacing = 16

        carousel.showsVerticalScrollIndicator = false
        carousel.showsHorizontalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = carousel.dequeueReusableCell(forIndexPath: indexPath ) as CarouselCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPage = carouselFlowLayout.currentCenteredPage
        if currentPage != indexPath.row {
            carouselFlowLayout.scrollToPage(index: indexPath.row, animated: true)
        }
    }
    
}
