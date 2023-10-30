//
//  HomeColCell2.swift
//  Product1Minggu1
//
//  Created by Eky on 30/10/23.
//

import UIKit

class HomeColCell2: UICollectionViewCell {

    @IBOutlet weak var mainButton: UIButton!
    
    var onTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainButton.addTarget(self, action: #selector(onButtonTapped), for: .touchDown)
    }
    
    @objc func onButtonTapped() {
        onTap?()
    }
}

extension HomeColCell2 {
    
}
