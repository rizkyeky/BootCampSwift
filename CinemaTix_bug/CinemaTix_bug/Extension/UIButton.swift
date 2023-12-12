//
//  ExtUIButton.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

extension UIButton {
    
    func setAnimateBounce(withDuration: Double = 0.081, scale: Double = 0.92) {
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
