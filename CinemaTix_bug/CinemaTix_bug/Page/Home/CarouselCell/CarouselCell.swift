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
    let boxBlur = UIView()
    
    var onTap: (() -> Void)?
    var onTapBookBtn: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        card.onTap = {
            self.onTap?()
        }
        
        card.backgroundView = UIImageView(image: UIImage(named: "imagenotfound"))
        
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
            make.width.height.equalTo(self.boxBlur)
            make.top.left.right.bottom.equalTo(self.boxBlur)
        }
        
        title.text = "-"
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.textColor = .white
        boxBlur.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(self.boxBlur).offset(16)
            make.left.equalTo(self.boxBlur).offset(16)
        }
        
        subtitle.text = "-"
        subtitle.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitle.textColor = .white
        boxBlur.addSubview(subtitle)
        subtitle.snp.makeConstraints { make in
            make.bottom.equalTo(self.boxBlur).offset(-16)
            make.left.equalTo(self.boxBlur).offset(16)
        }
        
        bookButton.setTitle("Book Now", for: .normal)
        boxBlur.addSubview(bookButton)
        bookButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(32)
            make.right.equalTo(self.boxBlur).offset(-16)
            make.centerY.equalTo(self.boxBlur.snp.centerY)
        }
        bookButton.addAction(UIAction { _ in
            self.onTapBookBtn?()
        }, for: .touchUpInside)
        
        title.snp.makeConstraints { make in
            make.right.equalTo(self.bookButton.snp.left).offset(-8)
        }
    }
}
