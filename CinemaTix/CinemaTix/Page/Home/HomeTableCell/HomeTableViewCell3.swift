//
//  HomeTableViewCell3.swift
//  CinemaTix
//
//  Created by Eky on 09/11/23.
//

import UIKit

class HomeTableViewCell3: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    
    static let height = 220
    static let heightItem = 212
    
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
        
        collection.decelerationRate = .fast
        
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
