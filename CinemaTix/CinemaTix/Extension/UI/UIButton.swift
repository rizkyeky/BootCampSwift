//
//  ExtUIButton.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

extension UIButton {
    
    convenience init(title: String, isBold: Bool = false, icon: UIImage? = nil, iconSize: CGSize? = nil, foregroundColor: UIColor = .white, backgroundColor: UIColor? = AppColor.accent, frame: CGRect = .init(x: 0, y: 0, width: 300, height: 48), cornerRadius: Double = 8.0, tintForegroundColor: UIColor? = nil, tintBackgroundColor: UIColor? = nil) {
        self.init(frame: frame)
        
        if title != "" {
            var attributes: [NSAttributedString.Key: AnyObject] = [
                NSAttributedString.Key.foregroundColor: foregroundColor
            ]
            if isBold {
                attributes[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 18)
            }
            let titleAttributed = NSMutableAttributedString(string: title, attributes: attributes)
            setAttributedTitle(titleAttributed, for: .normal)
        }
        
        self.backgroundColor = backgroundColor
        self.tintColor = foregroundColor
        
        setAnimateBounce(tintForegroundColor: tintForegroundColor, tintBackgroundColor: tintBackgroundColor)
        makeCornerRadius(cornerRadius)
        
        if let icon = icon?.resize(iconSize ?? CGSize(width: 32, height: 32)) {
            let image = UIImageView(image: icon.reColor(foregroundColor))
            image.tintColor = foregroundColor
            addSubview(image)
            image.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                if title != "" {
                    make.left.equalTo(self).offset(16)
                } else {
                    make.centerX.equalTo(self)
                }
                make.width.height.equalTo(iconSize?.width ?? 32)
            }
        }
    }
    
    func setAnimateBounce(withDuration: Double = 0.081, scale: Double = 0.96, tintForegroundColor: UIColor? = nil, tintBackgroundColor: UIColor? = nil) {
        let oriBackColor = self.backgroundColor
        let oriForeColor = self.tintColor
        self.addAction(UIAction { _ in
            self.onTapDownAnimateBounce(withDuration, scale, tintForegroundColor: tintForegroundColor, tintBackgroundColor: tintBackgroundColor)
        }, for: .touchDown)
        self.addAction(UIAction { _ in
            self.onTapUpAnimateBounce(withDuration, oriForeColor: oriForeColor, oriBackColor: oriBackColor)
        }, for: .touchUpInside)
        self.addAction(UIAction { _ in
            self.onTapUpAnimateBounce(withDuration, oriForeColor: oriForeColor, oriBackColor: oriBackColor)
        }, for: .touchUpOutside)
    }
    
    private func onTapDownAnimateBounce(_ withDuration: Double, _ scale: Double, tintForegroundColor: UIColor? = nil, tintBackgroundColor: UIColor? = nil) {
        UIView.animate(withDuration: withDuration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            if let tintBackgroundColor = tintBackgroundColor {
                self.backgroundColor = tintBackgroundColor
            }
            if let tintForegroundColor = tintForegroundColor {
                self.tintColor = tintForegroundColor
                self.setTitleColor(tintForegroundColor, for: .normal)
            }
        })
    }
    
    private func onTapUpAnimateBounce(_ withDuration: Double, oriForeColor: UIColor? = nil, oriBackColor: UIColor? = nil) {
        UIView.animate(withDuration: withDuration, animations: {
            self.transform = CGAffineTransform.identity
            if let oriBackColor = oriBackColor {
                self.backgroundColor = oriBackColor
            }
            if let oriForeColor = oriForeColor {
                self.tintColor = oriForeColor
                self.setTitleColor(oriForeColor, for: .normal)
            }
        })
    }
}
