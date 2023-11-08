//
//  RecomCollectionViewCell.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit

class RecomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var card: Card!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        card.backgroundImage = UIImage(named: "marvel")
        
        let boxBlur = UIView()
        boxBlur.backgroundColor = .clear
        card.addSubview(boxBlur)
        boxBlur.snp.makeConstraints { make in
            make.height.equalTo(80)
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
