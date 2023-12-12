//
//  ExtUIButton.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

extension UIButton {
    
    convenience init(title: String, isBold: Bool = false, icon: UIImage? = nil, foregroundColor: UIColor = .white, backgroundColor: UIColor? = AppColor.accent, frame: CGRect = .init(x: 0, y: 0, width: 300, height: 48), cornerRadius: Double = 8.0) {
        self.init(frame: frame)
        
        if isBold {
            let titleAttributed = NSMutableAttributedString(string: title, attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: foregroundColor
            ])
            setAttributedTitle(titleAttributed, for: .normal)
        } else {
            setTitle(title, for: .normal)
        }
        
        self.backgroundColor = backgroundColor
        
        setAnimateBounce()
        makeCornerRadius(cornerRadius)
        
        if let icon = icon?.resize(CGSize(width: 32, height: 32)) {
            let image = UIImageView(image: icon.reColor(foregroundColor))
            image.tintColor = foregroundColor
            addSubview(image)
            image.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.left.equalTo(self).offset(16)
                make.width.height.equalTo(32)
            }
        }
    }
    
    func setAnimateBounce(withDuration: Double = 0.081, scale: Double = 0.96) {
        self.addAction(UIAction { _ in
            self.onTapDownAnimateBounce(withDuration, scale)
        }, for: .touchDown)
        self.addAction(UIAction { _ in
            self.onTapUpAnimateBounce(withDuration)
        }, for: .touchUpInside)
        self.addAction(UIAction { _ in
            self.onTapUpAnimateBounce(withDuration)
        }, for: .touchUpOutside)
    }
    
    private func onTapDownAnimateBounce(_ withDuration: Double, _ scale: Double) {
        UIView.animate(withDuration: withDuration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    private func onTapUpAnimateBounce(_ withDuration: Double) {
        UIView.animate(withDuration: withDuration, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
