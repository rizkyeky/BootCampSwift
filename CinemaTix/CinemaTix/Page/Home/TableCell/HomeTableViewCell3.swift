//
//  HomeTableViewCell3.swift
//  CinemaTix
//
//  Created by Eky on 09/11/23.
//

import UIKit
import CenteredCollectionView

class HomeTableViewCell3: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    
    var collectionFlowLayout: CenteredCollectionViewFlowLayout!
    
    static let height = 300
    static let heightItem = 300
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension HomeTableViewCell3: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollection() {
        collection.delegate = self
        collection.dataSource = self
        
        collection.registerCellWithNib(RecomCollectionViewCell.self)
        
        collectionFlowLayout = (collection.collectionViewLayout as! CenteredCollectionViewFlowLayout)
        
        collectionFlowLayout.itemSize = CGSize(width: 240, height: HomeTableViewCell3.heightItem)
        collectionFlowLayout.minimumLineSpacing = 16
        
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(forIndexPath: indexPath ) as RecomCollectionViewCell
        
        return cell
    }
}
