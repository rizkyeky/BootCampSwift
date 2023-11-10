//
//  RecomCollectionViewCell.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit

class RecomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var card: Card!
    
    let title = UILabel()
    let subtitle = UILabel()
    
    var onTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        card.onTap = {
            self.onTap?()
        }
        
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
        
        title.text = "Avengers Endgame"
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.textColor = .white
        boxBlur.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(boxBlur).offset(16)
            make.left.equalTo(boxBlur).offset(16)
        }
        
        subtitle.text = "13+ | Rating: 4.8"
        subtitle.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitle.textColor = .white
        boxBlur.addSubview(subtitle)
        subtitle.snp.makeConstraints { make in
            make.bottom.equalTo(boxBlur).offset(-16)
            make.left.equalTo(boxBlur).offset(16)
        }
    }

}
