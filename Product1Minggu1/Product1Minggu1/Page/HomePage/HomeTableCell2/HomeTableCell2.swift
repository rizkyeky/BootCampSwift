//
//  HomeTableCell.swift
//  Product1Minggu1
//
//  Created by Eky on 30/10/23.
//

import UIKit

class HomeTableCell2: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainColl: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMainColl()
    }
    
    func setupMainColl() {
        mainColl.dataSource = self
        mainColl.delegate = self
        mainColl.registerCellWithNib(HomeCollCell1.self)
        mainColl.registerCellWithNib(HomeColCell2.self)
        mainColl.showsHorizontalScrollIndicator = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension HomeTableCell2: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath ) as HomeColCell2
        cell.mainButton.setTitle("CollCell2 \(indexPath.row)", for: .normal)
        cell.onTap = {
            print("CollCell2 \(indexPath.row)")
        }
        return cell
    }
    
    
    
}
