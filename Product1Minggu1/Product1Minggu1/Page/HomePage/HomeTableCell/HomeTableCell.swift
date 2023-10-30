//
//  HomeTableCell.swift
//  Product1Minggu1
//
//  Created by Eky on 30/10/23.
//

import UIKit

class HomeTableCell: UITableViewCell {

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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension HomeTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath ) as HomeCollCell1
        cell.mainLabel.text = "HomeCollCell1 \(indexPath.row)"
        return cell
    }
    
    
    
}
