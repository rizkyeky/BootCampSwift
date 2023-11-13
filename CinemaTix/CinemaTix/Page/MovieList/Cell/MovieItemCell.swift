//
//  MovieItemCell.swift
//  CinemaTix
//
//  Created by Eky on 13/11/23.
//

import UIKit

class MovieItemCell: UICollectionViewCell {

    @IBOutlet weak var card: Card!
    
    static let height = 240
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let boxBlur = UIView()
        boxBlur.backgroundColor = .clear
        card.addSubview(boxBlur)
        boxBlur.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(self.card)
            make.bottom.equalTo(self.card)
            make.centerX.equalTo(self.card)
        }
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        boxBlur.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.width.height.equalTo(boxBlur)
            make.top.left.right.bottom.equalTo(boxBlur)
        }
    }

}
