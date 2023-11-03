//
//  ExtUIButton.swift
//  TimeAndClock
//
//  Created by Eky on 03/11/23.
//

import Foundation
import UIKit

extension UIView {
    
    func onTapDownAnimateBounce() {
        UIView.animate(withDuration: 0.081, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    func onTapUpAnimateBounce() {
        UIView.animate(withDuration: 0.81, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
