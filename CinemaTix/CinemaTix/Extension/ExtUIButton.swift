//
//  ExtUIButton.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func setAnimateBounce() {
        self.addAction(UIAction { _ in
            self.onTapDownAnimateBounce()
        }, for: .touchDown)
        self.addAction(UIAction { _ in
            self.onTapUpAnimateBounce()
        }, for: .touchUpInside)
    }
    
    func onTapDownAnimateBounce() {
        UIView.animate(withDuration: 0.081, animations: {
            self.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        })
    }
    
    func onTapUpAnimateBounce() {
        UIView.animate(withDuration: 0.081, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
