//
//  CastCell.swift
//  CinemaTix
//
//  Created by Eky on 14/11/23.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    @IBOutlet weak var card: Card!
    
    static let height = 200
    
    let title = UILabel()
    
    var onTap: (() -> Void)?
    
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
        
        title.text = "-"
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.textColor = .white
        title.numberOfLines = 2
        boxBlur.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalTo(boxBlur.snp.centerY)
            make.left.equalTo(boxBlur).offset(16)
            make.right.equalTo(boxBlur).offset(-16)
        }
    }

}
