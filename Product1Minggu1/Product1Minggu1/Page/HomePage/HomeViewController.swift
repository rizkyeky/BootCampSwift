//
//  HomeViewController.swift
//  Product1Minggu1
//
//  Created by Eky on 27/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellWithNib(HomeCollectionCell.self)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // set number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // set cell of collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath ) as HomeCollectionCell
        cell.labelView.text = "Label \(indexPath.row)"
        return cell
    }
    
}
