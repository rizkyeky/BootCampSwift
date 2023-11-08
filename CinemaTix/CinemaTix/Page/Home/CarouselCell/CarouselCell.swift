//
//  CarouselCell.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit
import SnapKit

class CarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var card: Card!
    
    let title = UILabel()
    let subtitle = UILabel()
    let bookButton = UIButton(configuration: .filled())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        card.backgroundImage = UIImage(named: "joker")
        
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
        
        title.text = "JOKER 1990"
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.textColor = .white
        boxBlur.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(boxBlur).offset(16)
            make.left.equalTo(boxBlur).offset(16)
        }
        
        subtitle.text = "18+ | Rating: 4.8"
        subtitle.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitle.textColor = .white
        boxBlur.addSubview(subtitle)
        subtitle.snp.makeConstraints { make in
            make.bottom.equalTo(boxBlur).offset(-16)
            make.left.equalTo(boxBlur).offset(16)
        }
        
        bookButton.setTitle("Book Now", for: .normal)
        boxBlur.addSubview(bookButton)
        bookButton.snp.makeConstraints { make in
            make.right.equalTo(boxBlur).offset(-16)
            make.centerY.equalTo(boxBlur.snp.centerY)
        }
    }
}
